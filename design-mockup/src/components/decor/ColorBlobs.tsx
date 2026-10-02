import React from 'react';

export function RainbowHairline() {
  return <div aria-hidden="true" className="to-rainbow-hairline" />;
}

export function GradientText({ children }: { children: React.ReactNode }) {
  return <span className="to-gradient-text">{children}</span>;
}

export function RainbowBadge({ children }: { children: React.ReactNode }) {
  return (
    <span className="to-rainbow-badge">
      <span className="to-rainbow-badge-dot" />
      {children}
    </span>
  );
}

const tileColors = ['is-blue', 'is-pink', 'is-green', 'is-orange'] as const;

export function ColorIconTile({
  children,
  color,
  style,
}: {
  children: React.ReactNode;
  color?: (typeof tileColors)[number];
  style?: React.CSSProperties;
}) {
  const c = color ?? tileColors[Math.floor(Math.random() * tileColors.length)];
  return <span className={`to-icon-tile ${c}`} style={style}>{children}</span>;
}