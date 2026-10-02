import React from 'react';

export default function Aurora({ variant = 'hero' }: { variant?: 'hero' | 'section' }) {
  return (
    <div className={`to-aurora to-aurora-${variant}`} aria-hidden="true">
      <span className="to-blob to-blob-green" />
      <span className="to-blob to-blob-teal" />
      <span className="to-blob to-blob-sky" />
      <span className="to-blob to-blob-violet" />
      <span className="to-blob to-blob-pink" />
      <span className="to-blob to-blob-amber" />
    </div>
  );
}