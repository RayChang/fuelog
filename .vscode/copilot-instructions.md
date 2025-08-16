# GitHub Copilot Code Generation Instructions

## Project Overview

Fuelog is a Turborepo monorepo for fuel tracking application with both web and Python components.

> **Note:** For complete development commands and detailed architecture information, see [CLAUDE.md](../CLAUDE.md) in the project root.

## Architecture & Workspace Structure

### Monorepo Layout

- **apps/web** - Main Next.js application (port 3030) with Tailwind CSS
- **apps/crawler** - Python CLI tool for fuel price data crawling
- **packages/ui** - Shared React component library (Button, Card, Code)
- **packages/db** - Prisma database package with PostgreSQL schema
- **packages/eslint-config** - Shared ESLint configurations
- **packages/typescript-config** - Shared TypeScript configurations

### Key Technologies

- **Turborepo** for monorepo build orchestration with Python task support
- **pnpm** as package manager with workspaces (NEVER use npm or yarn)
- **Next.js 15.4.5** with App Router and Turbopack
- **React 19.1.0** and TypeScript 5.8.x
- **Tailwind CSS 4.x** for styling
- **Prisma 6.13.0** with PostgreSQL for database management
- **Python 3.13+** with uv for dependency management
- **Typer** for Python CLI framework

## Development Guidelines

### TypeScript & Next.js (Web App)

- Always use TypeScript for new files in this Next.js project
- Follow ESLint rules: single quotes, semicolons, 2-space indentation
- Use Tailwind CSS for styling, prefer utility classes over custom CSS
- Use the @repo/\* import path for shared packages (@repo/ui, @repo/db)
- Prefer functional components with hooks over class components
- Use proper TypeScript types, avoid 'any' unless absolutely necessary
- Use Next.js App Router pattern
- Import order: React → Next.js → Third-party → @repo packages → Relative imports

### Python (Crawler App)

- Use Ruff formatting, follow PEP 8, use type hints
- Use httpx for HTTP requests, BeautifulSoup for parsing, Pydantic for validation, Typer for CLI
- Python 3.13+ required, use modern async/await patterns for web scraping
- Use uv for Python dependency management in crawler app
- Follow Ruff rules: E, W, F, I, N, UP, B, S, C4, PIE, RUF, A, T20, DTZ, SLF, PERF

#### Security Best Practices for Web Scraping

- Implement rate limiting to respect Taiwan fuel station APIs (use httpx rate limiting)
- Use proper User-Agent headers to identify as legitimate crawler
- Implement exponential backoff for failed requests
- Never hardcode API keys or credentials in source code
- Use environment variables for sensitive configuration
- Respect robots.txt and terms of service
- Implement request timeouts to prevent hanging connections
- Use HTTPS whenever possible for secure data transmission

### Database & Multi-tenant Architecture

- Use Prisma ORM with PostgreSQL
- Follow multi-tenant architecture with tenant isolation
- Include tenant context in database queries and API endpoints
- Database supports: user management, vehicle tracking, fuel records, gas station data
- Prisma client generated to `generated/prisma/`

### Domain Context - Fuel Tracking

- Core entities: vehicles, fuel records, mileage, gas stations, users, tenants
- Taiwan fuel brands: CPC, FORMOSA, NPC, TAYA, FUMAO
- Track: vehicle brands/models/ownership, fuel consumption, mileage, expenses

## Code Style & Formatting

### Prettier Configuration

- Line Width: 100 characters
- Indentation: 2 spaces (no tabs)
- Quotes: Single quotes for strings
- Semicolons: Always required
- Trailing Commas: ES5 compatible
- End of Line: LF (Unix-style)
- Auto import sorting enabled
- Tailwind class sorting enabled

### ESLint Rules (Airbnb-inspired)

- Single quotes required ('string')
- Semicolons always required (;)
- 2 spaces indentation
- Comma dangle required in multiline structures
- React JSX allowed in .tsx files
- React scope not required with new JSX transform
- Strict unused variable checking
- Console warnings allowed for development

## Development Commands

### Core Commands

- `pnpm dev` - Start development servers for all apps
- `pnpm build` - Build all apps and packages
- `pnpm lint` - Run ESLint across all workspaces
- `pnpm format` - Format code with Prettier
- `pnpm check-types` - Run TypeScript type checking

### Database Commands

- `pnpm db:pull` - Pull database schema from PostgreSQL
- `pnpm db:generate` - Generate Prisma client from schema
- `pnpm db:migrate` - Run database migrations in development
- `pnpm db:studio` - Open Prisma Studio for database management

### Python Commands

- `pnpm python:sync` - Install Python dependencies with uv
- `pnpm python:lint` - Run Python linting with Ruff
- `pnpm python:type-check` - Run Python type checking with MyPy
- `pnpm python:test` - Run Python tests with pytest
- `pnpm python:run` - Run the Python crawler CLI

### Per-app Commands

- `pnpm --filter web dev` - Start only web app (port 3030)
- `pnpm --filter crawler python:sync` - Install crawler dependencies only
- `pnpm --filter @repo/ui lint` - Lint UI package only
- `pnpm --filter @repo/db db:studio` - Open database studio

## Git & Commit Guidelines

### Commit Message Format

Follow Conventional Commits format: `type(scope): description`

**Types:** feat, fix, docs, style, refactor, test, chore
**Scopes:** web, crawler, ui, db, config, deps, docs, ci, release

**Examples:**

- `feat(web): add fuel consumption tracking dashboard`
- `fix(crawler): handle network timeout errors`
- `chore(config): update ESLint rules for better code quality`

### Pre-commit Hooks

- Prettier formatting for TypeScript, JavaScript, JSON, CSS, Markdown, YAML
- ESLint checking with Airbnb-inspired rules for TypeScript and JavaScript
- Ruff formatting and linting for Python files in crawler app
- TypeScript type checking when TS files are modified

## Code Examples

### TypeScript Component Example

```typescript
import { Button } from '@repo/ui/button';
import { getFuelRecords } from '@repo/db';

interface FuelRecord {
  id: string;
  vehicleId: string;
  mileage: number;
  fuelAmount: number;
  price: number;
  stationBrand: 'CPC' | 'FORMOSA' | 'NPC' | 'TAYA' | 'FUMAO';
  tenantId: string;
}

interface FuelRecordListProps {
  tenantId: string;
}

export function FuelRecordList({ tenantId }: FuelRecordListProps) {
  // Always include tenantId in database queries for multi-tenant isolation
  const records = getFuelRecords({ tenantId });

  return (
    <div className="space-y-4">
      {records.map((record) => (
        <div key={record.id} className="p-4 border rounded-lg">
          <p className="font-semibold">{record.stationBrand}</p>
          <p>Mileage: {record.mileage} km</p>
          <p>Amount: {record.fuelAmount} L</p>
        </div>
      ))}
    </div>
  );
}
```

### Python Crawler Example

```python
import asyncio
from datetime import datetime
from typing import List

import httpx
from bs4 import BeautifulSoup
from pydantic import BaseModel
import typer

class FuelPrice(BaseModel):
    brand: str
    station_name: str
    price: float
    location: str
    updated_at: datetime

async def fetch_fuel_prices(brand: str) -> List[FuelPrice]:
    """Fetch fuel prices for Taiwan fuel brands: CPC, FORMOSA, NPC, TAYA, FUMAO"""
    async with httpx.AsyncClient() as client:
        response = await client.get(f"https://example.com/api/{brand}")
        soup = BeautifulSoup(response.text, 'html.parser')

        prices = []
        for station in soup.find_all('div', class_='station'):
            price_data = FuelPrice(
                brand=brand,
                station_name=station.find('h3').text,
                price=float(station.find('.price').text),
                location=station.find('.location').text,
                updated_at=datetime.now()
            )
            prices.append(price_data)

        return prices

def main(brand: str = typer.Argument(..., help="Fuel brand to crawl")) -> None:
    """CLI entry point for fuel price crawler"""
    if brand not in ['CPC', 'FORMOSA', 'NPC', 'TAYA', 'FUMAO']:
        typer.echo(f"Invalid brand: {brand}")
        raise typer.Exit(1)

    prices = asyncio.run(fetch_fuel_prices(brand))
    typer.echo(f"Fetched {len(prices)} prices for {brand}")

if __name__ == "__main__":
    typer.run(main)
```

### Database Query Example (Prisma)

```typescript
// Always include tenant context for multi-tenant isolation
export async function getUserVehicles(userId: string, tenantId: string) {
  return await prisma.vehicle.findMany({
    where: {
      userId,
      tenantId, // Essential for multi-tenant data isolation
    },
    include: {
      fuelRecords: {
        orderBy: { createdAt: 'desc' },
        take: 10,
      },
    },
  });
}
```
