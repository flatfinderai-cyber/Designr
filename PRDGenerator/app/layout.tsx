import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "PRD Generator | Designr",
  description: "Interactive PRD.json generator for Ralph-loop automation",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body className="bg-gradient-to-br from-slate-900 to-slate-800 min-h-screen">
        <div className="max-w-4xl mx-auto p-6">
          {children}
        </div>
      </body>
    </html>
  );
}
