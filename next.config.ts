import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  /* config options here */
  async redirects() {
    return [
      {
        source: '/practice',
        destination: '/courses',
        permanent: true,
      },
      {
        source: '/practice/:subject',
        destination: '/courses',
        permanent: true,
      },
      {
        source: '/practice/:subject/:topic',
        destination: '/courses',
        permanent: true,
      },
      {
        source: '/practice/:subject/:topic/:set',
        destination: '/practice/:set',
        permanent: true,
      }
    ];
  }
};

export default nextConfig;
