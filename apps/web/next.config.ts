import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  transpilePackages: [
    "@repo/supabase",
    "@repo/types",
    "@repo/utils",
    "@repo/validation",
  ],
};

export default nextConfig;
