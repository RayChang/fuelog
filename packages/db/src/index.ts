import { PrismaClient } from '../generated/prisma';
console.log('dbbbb DATABASE_URL =', process.env.DATABASE_URL);

type GlobalWithPrisma = typeof globalThis & { __prisma?: PrismaClient };
const g = globalThis as GlobalWithPrisma;

export const prisma: PrismaClient =
  g.__prisma ??
  new PrismaClient({
    log: process.env.NODE_ENV === 'development' ? ['query', 'error', 'warn'] : ['error'],
  });

if (process.env.NODE_ENV !== 'production') g.__prisma = prisma;

// 可選：轉出型別
export * from '../generated/prisma';
