import React from 'react';

const names = ['Meridian Freight', 'Coastal Transit', 'Northline Logistics', 'Skyway Cargo', 'Harborline', 'BlueRoute'];

export default function TrustedBy() {
  return (
    <section className="landing-container to-logo-strip">
      <p className="to-logo-strip-title">Trusted by operations teams at</p>
      <div className="to-logo-row">
        {names.map((name) => (
          <span key={name} className="to-logo-word">{name}</span>
        ))}
      </div>
    </section>
  );
}