import { PrismaClient } from '../generated/prisma';

type GlobalWithPrisma = typeof globalThis & { __prisma?: PrismaClient };
const g = globalThis as GlobalWithPrisma;

export const prisma: PrismaClient =
  g.__prisma ??
  new PrismaClient({
    log: process.env.NODE_ENV === 'development' ? ['query', 'error', 'warn'] : ['error'],
  });

if (process.env.NODE_ENV !== 'production') g.__prisma = prisma;

export * from '../generated/prisma';
