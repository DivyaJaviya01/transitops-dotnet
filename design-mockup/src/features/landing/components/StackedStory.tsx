import React from 'react';

const slides = [
  {
    id: 'track',
    index: '01',
    eyebrow: 'Track',
    title: 'Every vehicle, one single view',
    desc: 'From acquisition to retirement, Fleet Management keeps type, load capacity, odometer, and status in a single source of truth your whole team can read.',
    image: 'https://images.unsplash.com/photo-1601584115197-04ecc0da31d7?auto=format&fit=crop&w=1200&q=80',
    alt: 'Fleet of freight trucks',
    flip: false,
  },
  {
    id: 'dispatch',
    index: '02',
    eyebrow: 'Dispatch',
    title: 'Trips that book themselves safely',
    desc: 'Plan, dispatch, and complete trips with built-in capacity and licence validation at every step — an over-capacity vehicle can never leave the yard.',
    image: 'https://images.unsplash.com/photo-1578575437130-527eed3abbec?auto=format&fit=crop&w=1200&q=80',
    alt: 'Shipping containers at the port',
    flip: true,
  },
  {
    id: 'maintain',
    index: '03',
    eyebrow: 'Maintain',
    title: 'Downtime that finally has a price tag',
    desc: 'Open and close work orders, track repair costs against the vehicle that earned them, and keep the fleet out of the shop only when it must be.',
    image: 'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?auto=format&fit=crop&w=1200&q=80',
    alt: 'Heavy equipment transport',
    flip: false,
  },
];

export default function StackedStory() {
  return (
    <section className="to-section hairline-t" id="story">
      <div className="landing-container">
        <div className="to-section-head">
          <span className="to-eyebrow">The Fleet Lifecycle</span>
          <h2 className="to-h2">Three stages. One platform. Zero gaps.</h2>
          <p className="to-lead">
            A fleet travels through track, dispatch, and maintenance every single day. Keep scrolling to follow the journey.
          </p>
        </div>
      </div>

      <div className="landing-container">
        <ul className="to-stack-list" style={{ '--numcards': slides.length } as React.CSSProperties}>
          {slides.map((s, i) => (
            <li
              key={s.id}
              className="to-stack-card"
              style={{ '--index': i + 1 } as React.CSSProperties}
            >
              <div className={`to-stack-card-content ${s.flip ? 'is-flipped' : ''}`}>
                <div className="to-stack-card-media">
                  <img src={s.image} alt={s.alt} loading="lazy" />
                </div>
                <div className="to-stack-card-copy">
                  <span className="to-stack-card-index">{s.index}</span>
                  <span className="to-eyebrow">{s.eyebrow}</span>
                  <h3 className="to-stack-card-title">{s.title}</h3>
                  <p className="to-stack-card-desc">{s.desc}</p>
                </div>
              </div>
            </li>
          ))}
        </ul>
      </div>
    </section>
  );
}