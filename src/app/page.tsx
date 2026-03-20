import Image from "next/image";
import Link from "next/link";

export default function Home() {
  return (
    <div className="flex min-h-screen items-center justify-center bg-zinc-50 font-sans dark:bg-black">
      <main className="flex min-h-screen w-full max-w-3xl flex-col items-center justify-between py-32 px-16 bg-white dark:bg-black sm:items-start">
        <Image
          className="dark:invert"
          src="/next.svg"
          alt="Next.js logo"
          width={100}
          height={20}
          priority
        />
        <div className="flex flex-col items-center gap-8 text-center sm:items-start sm:text-left">
          <h1 className="max-w-2xl text-4xl sm:text-5xl font-bold leading-tight tracking-tight text-black dark:text-zinc-50">
            Welcome to Dristi-prep, your 1 stop accessible exam preparation platform!
          </h1>
          <div className="flex flex-col gap-4 text-base font-medium sm:flex-row w-full sm:w-auto">
            <Link
              href="/login"
              className="flex h-12 w-full sm:w-[158px] items-center justify-center gap-2 rounded-full bg-foreground px-5 text-background transition-colors hover:bg-[#383838] dark:hover:bg-[#ccc]"
            >
              Login
            </Link>
            <Link
              href="/practice"
              className="flex h-12 w-full sm:w-[158px] items-center justify-center gap-2 rounded-full border border-solid border-black/[.08] px-5 transition-colors hover:border-transparent hover:bg-black/[.04] dark:border-white/[.145] dark:hover:bg-[#1a1a1a]"
            >
              Practice
            </Link>
          </div>
        </div>
      </main>
    </div>
  );
}
