<%@ Page Title="Smart Transport Operations Platform" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Home.aspx.cs" Inherits="TransitOPS_net.Guest.Home" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

        <script>
            document.documentElement.className += ' js-reveal';
        </script>

        <style>
            /* Page-local styles for Home */
            .to-hero-title-left {
                text-align: left;
                margin-left: 0;
            }

            .to-hero-sub-left {
                text-align: left;
                margin-left: 0;
            }

            .to-hero-actions-left {
                justify-content: flex-start;
            }

            .to-hero-note-left {
                text-align: left;
            }

            .to-hero-media {
                position: relative;
                width: 100%;
                height: 100%;
            }

            .to-hero-media-box {
                aspect-ratio: 4 / 3;
                height: auto;
                min-height: 0;
                border: 0;
                border-radius: 0;
                background: transparent;
                box-shadow: none;
                transition: transform 0.3s cubic-bezier(0.16, 1, 0.3, 1), box-shadow 0.3s ease;
            }



            @media (min-width: 1024px) {
                .to-hero-media-box {
                    aspect-ratio: auto;
                    height: 680px;
                }
            }

            .to-hero-video-wrap {
                position: absolute;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: hidden;
                background: transparent;
            }

            .to-hero-video {
                position: absolute;
                left: 50%;
                top: 50%;
                width: calc(100% + 2px);
                height: calc(100% + 2px);
                transform: translate(-50%, -50%) scale(1.2);
                object-fit: cover;
                display: block;
            }

            .to-stats {
                gap: 0;
            }

            .to-stat {
                padding: 40px 32px;
                text-align: center;
            }

            .to-stat+.to-stat {
                border-top: 1px solid var(--to-line);
            }

            .to-stat-value {
                font-size: 2.4rem;
                margin-bottom: 8px;
            }

            .to-stat-label {
                font-size: 13.5px;
                margin-top: 0;
                line-height: 1.5;
            }

            @media (min-width: 768px) {
                .to-stat:nth-child(odd) {
                    border-right: 1px solid var(--to-line);
                }

                .to-stat:nth-child(n + 3) {
                    border-top: 1px solid var(--to-line);
                }
            }

            @media (min-width: 1024px) {
                .to-stat {
                    border-right: 1px solid var(--to-line);
                }

                .to-stat+.to-stat {
                    border-top: none;
                    border-left: 1px solid var(--to-line);
                }

                .to-stat:last-child {
                    border-right: none;
                }
            }

            .to-stack-list {
                list-style: none;
                margin: 0;
                padding: 0;
                --numcards: 3;
                --stack-card-height: clamp(420px, 58vw, 560px);
                --stack-card-margin: 24px;
                --stack-top-offset: 14px;
                --stack-sticky-top: 88px;
                display: grid;
                grid-template-columns: 1fr;
                grid-template-rows: repeat(var(--numcards), var(--stack-card-height));
                gap: var(--stack-card-margin);
                padding-bottom: calc(var(--numcards) * var(--stack-top-offset) + var(--stack-card-margin));
            }

            .to-stack-card {
                position: sticky;
                top: var(--stack-sticky-top);
                padding-top: calc(var(--index) * var(--stack-top-offset));
            }

            .to-stack-card-content {
                height: 100%;
                box-sizing: border-box;
                background: #ffffff;
                border: 1px solid var(--to-line-strong);
                border-radius: 22px;
                box-shadow:
                    0 1px 2px rgba(16, 24, 40, 0.04),
                    0 20px 48px rgba(16, 24, 40, 0.1);
                overflow: hidden;
                display: grid;
                grid-template-columns: minmax(0, 1fr) minmax(0, 1fr);
                grid-template-areas: 'media copy';
                transform-origin: 50% 0%;
                will-change: transform;
            }

            .to-stack-card-content.is-flipped {
                grid-template-areas: 'copy media';
            }

            .to-stack-card-media {
                grid-area: media;
                min-height: 0;
                overflow: hidden;
            }

            .to-stack-card-media img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                display: block;
            }

            .to-stack-card-copy {
                grid-area: copy;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: flex-start;
                gap: 16px;
                padding: 48px;
                position: relative;
            }

            .to-stack-card-index {
                position: absolute;
                top: 28px;
                right: 32px;
                font-size: 44px;
                font-weight: 700;
                letter-spacing: -0.04em;
                line-height: 1;
                -webkit-text-stroke: 1px var(--to-line-strong);
                color: transparent;
                user-select: none;
            }

            .to-stack-card-copy .to-eyebrow {
                margin-bottom: 0;
            }

            .to-stack-card-title {
                font-size: clamp(22px, 2.6vw, 34px);
                font-weight: 700;
                letter-spacing: -0.03em;
                line-height: 1.15;
                color: var(--to-ink);
                margin: 0;
            }

            .to-stack-card-desc {
                font-size: 15.5px;
                line-height: 1.75;
                color: var(--to-ink-soft);
                margin: 0;
                max-width: 46ch;
            }

            @media (max-width: 767px) {
                .to-stack-list {
                    --stack-card-height: auto;
                }

                .to-stack-card-content,
                .to-stack-card-content.is-flipped {
                    grid-template-columns: 1fr;
                    grid-template-rows: 220px auto;
                    grid-template-areas:
                        'media'
                        'copy';
                }

                .to-stack-card-copy {
                    padding: 32px 26px 36px;
                }

                .to-stack-card-index {
                    top: 20px;
                    right: 24px;
                    font-size: 36px;
                }
            }

            @supports (animation-timeline: view()) {
                .to-stack-card {
                    --index0: calc(var(--index) - 1);
                    --reverse-index: calc(var(--numcards) - var(--index0));
                    --reverse-index0: calc(var(--reverse-index) - 1);
                }

                .to-stack-list {
                    view-timeline-name: --to-stack-scrolls-in-body;
                }

                .to-stack-card-content {
                    --start-range: calc(var(--index0) / var(--numcards) * 100%);
                    --end-range: calc(var(--index) / var(--numcards) * 100%);

                    animation: to-stack-scale linear forwards;
                    animation-timeline: --to-stack-scrolls-in-body;
                    animation-range:
                        exit-crossing var(--start-range) exit-crossing var(--end-range);
                }
            }

            @keyframes to-stack-scale {
                to {
                    transform: scale(calc(1.1 - calc(0.1 * var(--reverse-index))));
                }
            }

            .js-reveal .to-reveal {
                opacity: 0;
                transform: translateY(14px);
            }

            .js-reveal .to-reveal.is-visible {
                opacity: 1;
                transform: translateY(0);
                transition:
                    opacity 0.6s cubic-bezier(0.16, 1, 0.3, 1),
                    transform 0.6s cubic-bezier(0.16, 1, 0.3, 1);
            }

            @media (prefers-reduced-motion: reduce) {
                .js-reveal .to-reveal {
                    opacity: 1;
                    transform: none;
                }
            }
        </style>

    </asp:Content>


    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <main>

            <!-- HERO SECTION -->
            <section class="landing-container" aria-label="Hero overview section">

                <div class="to-hero-split">

                    <div class="to-hero-copy to-reveal">

                        <span class="to-badge" style="margin-bottom: 24px">
                            <span class="to-badge-dot"></span>
                            Smart Transport Operations Platform
                        </span>

                        <h1 class="to-hero-title to-hero-title-left">
                            Run your entire fleet from one
                            <span class="to-gradient-text">calm, clear place.</span>
                        </h1>

                        <p class="to-hero-sub to-hero-sub-left">
                            TransitOps unifies vehicles, drivers, trips, maintenance,
                            and expenses in one workspace &#8212; so your team
                            dispatches faster, spends less, and stays ahead of every move.
                        </p>

                        <div class="to-hero-actions to-hero-actions-left">

                            <a href="~/Guest/SignUp.aspx" runat="server" class="to-btn to-btn-primary to-btn-lg">

                                Get Started Free

                                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">

                                    <path d="M5 12h14" />
                                    <path d="m12 5 7 7-7 7" />

                                </svg>

                            </a>

                            <a href="~/Guest/SignIn.aspx" runat="server" class="to-btn to-btn-light to-btn-lg">
                                Sign In
                            </a>

                        </div>

                        <p class="to-hero-note to-hero-note-left">
                            No credit card required &#183; Set up in minutes
                        </p>

                    </div>


                    <div class="to-hero-media to-reveal">

                        <div class="to-hero-media-box">

                            <div class="to-hero-video-wrap">

                                <video class="to-hero-video"
                                    autoplay
                                    muted
                                    loop
                                    playsinline
                                    preload="metadata">
                                    <source src="../Images/hero_page.mp4" type="video/mp4" />
                                </video>

                            </div>

                        </div>

                    </div>

                </div>

            </section>


            <!-- LOGO STRIP -->
            <section class="landing-container to-logo-strip">

                <p class="to-logo-strip-title">
                    Trusted by operations teams at
                </p>

                <div class="to-logo-row">

                    <asp:Repeater ID="rptLogos" runat="server">

                        <ItemTemplate>

                            <span class="to-logo-word">
                                <%# Container.DataItem %>
                            </span>

                        </ItemTemplate>

                    </asp:Repeater>

                </div>

            </section>


            <!-- FEATURES SECTION -->
            <section class="to-section hairline-t" id="features">

                <div class="landing-container">

                    <div class="to-section-head">

                        <span class="to-eyebrow">
                            Everything Included
                        </span>

                        <h2 class="to-h2">
                            One platform for the entire fleet lifecycle
                        </h2>

                        <p class="to-lead">
                            Seven modules that talk to each other &#8212;
                            so nothing gets lost between a fuel log and a work order.
                        </p>

                    </div>


                    <div class="to-grid to-grid-3 to-reveal">

                        <asp:Repeater ID="rptFeatures" runat="server">

                            <ItemTemplate>

                                <div class="to-card">

                                    <span class="to-card-icon">

                                        <asp:Literal ID="litFeatureIcon" runat="server" Text='<%# Eval("Icon") %>' />

                                    </span>

                                    <h3 class="to-card-title">
                                        <%# Eval("Title") %>
                                    </h3>

                                    <p class="to-card-desc">
                                        <%# Eval("Description") %>
                                    </p>

                                </div>

                            </ItemTemplate>

                        </asp:Repeater>

                    </div>

                </div>

            </section>


            <!-- PRODUCT SECTION -->
            <section class="to-section hairline-t" id="product">

                <div class="landing-container">

                    <div class="to-section-head">

                        <span class="to-eyebrow">
                            Powered by Business Rules
                        </span>

                        <h2 class="to-h2">
                            Software that guards the details your team forgets
                        </h2>

                        <p class="to-lead">
                            Eleven built-in rules keep your operations honest &#8212;
                            from capacity checks to licence expiry validation.
                        </p>

                    </div>


                    <div class="to-grid to-grid-2 to-reveal">

                        <div class="to-card">

                            <h3 class="to-card-title">
                                Dispatch, without the paper trail
                            </h3>

                            <p class="to-card-desc">
                                Every trip moves through a clear pipeline &#8212;
                                Draft, Dispatched, Completed. The system refuses
                                an over-capacity vehicle or an expired licence
                                before it ever leaves the yard.
                            </p>

                        </div>


                        <div class="to-card">

                            <h3 class="to-card-title">
                                Costs that close the loop
                            </h3>

                            <p class="to-card-desc">
                                Close a maintenance order and the expense posts itself.
                                Finish a trip and the fuel log is recorded.
                                No double entry, no missing receipts.
                            </p>

                        </div>

                    </div>


                    <div class="to-grid to-grid-2" style="margin-top: 18px">

                        <div class="to-card">

                            <ul class="to-footer-list" style="gap: 16px">

                                <asp:Repeater ID="rptProductPoints" runat="server">

                                    <ItemTemplate>

                                        <li
                                            style="display: flex; align-items: center; gap: 12px; font-size: 14.5px; color: var(--to-ink-soft)">

                                            <span class="to-card-icon"
                                                style="width: 32px; height: 32px; margin: 0; border-radius: 8px">

                                                <asp:Literal ID="litPointIcon" runat="server"
                                                    Text='<%# Eval("Icon") %>' />

                                            </span>

                                            <%# Eval("Title") %>

                                        </li>

                                    </ItemTemplate>

                                </asp:Repeater>

                            </ul>

                        </div>


                        <div class="to-card"
                            style="display: flex; flex-direction: column; justify-content: center; gap: 6px">

                            <p class="to-card-desc" style="margin-bottom: 8px">
                                The dashboard answers the three questions every manager asks:
                            </p>

                            <p class="to-card-desc" style="font-weight: 650; color: var(--to-ink)">
                                How much of the fleet is earning right now?
                            </p>

                            <p class="to-card-desc" style="font-weight: 650; color: var(--to-ink)">
                                Which trip is at risk of going sideways?
                            </p>

                            <p class="to-card-desc" style="font-weight: 650; color: var(--to-ink)">
                                Where did the money go this month?
                            </p>

                        </div>

                    </div>

                </div>

            </section>


            <!-- FLEET LIFECYCLE SECTION -->
            <section class="to-section hairline-t" id="story">

                <div class="landing-container">

                    <div class="to-section-head">

                        <span class="to-eyebrow">
                            The Fleet Lifecycle
                        </span>

                        <h2 class="to-h2">
                            Three stages. One platform. Zero gaps.
                        </h2>

                        <p class="to-lead">
                            A fleet travels through track, dispatch, and maintenance
                            every single day. Keep scrolling to follow the journey.
                        </p>

                    </div>

                </div>


                <div class="landing-container">

                    <ul class="to-stack-list">

                        <asp:Repeater ID="rptStory" runat="server">

                            <ItemTemplate>

                                <li class="to-stack-card" style="--index: <%# Container.ItemIndex + 1 %>">

                                    <div class="to-stack-card-content<%# Eval(" ModifierClass") %>">

                                        <div class="to-stack-card-media">

                                            <img src="<%# Eval(" Image") %>"
                                            alt="<%# Eval("Alt") %>"
                                                loading="lazy" />

                                        </div>


                                        <div class="to-stack-card-copy">

                                            <span class="to-stack-card-index">
                                                <%# Eval("Index") %>
                                            </span>

                                            <span class="to-eyebrow">
                                                <%# Eval("Eyebrow") %>
                                            </span>

                                            <h3 class="to-stack-card-title">
                                                <%# Eval("Title") %>
                                            </h3>

                                            <p class="to-stack-card-desc">
                                                <%# Eval("Description") %>
                                            </p>

                                        </div>

                                    </div>

                                </li>

                            </ItemTemplate>

                        </asp:Repeater>

                    </ul>

                </div>

            </section>


            <!-- STATS SECTION -->
            <section class="to-section hairline-t" id="stats" style="padding: 72px 0">

                <div class="landing-container">

                    <div class="to-stats to-reveal">

                        <asp:Repeater ID="rptStats" runat="server">

                            <ItemTemplate>

                                <div class="to-stat">

                                    <div class="to-stat-value">
                                        <%# Eval("Value") %>
                                    </div>

                                    <div class="to-stat-label">
                                        <%# Eval("Label") %>
                                    </div>

                                </div>

                            </ItemTemplate>

                        </asp:Repeater>

                    </div>

                </div>

            </section>


            <!-- CTA SECTION -->
            <section class="to-section hairline-t to-cta">

                <div class="landing-container">

                    <div class="to-reveal">

                        <h2 class="to-cta-title">
                            Ready to take your fleet operations seriously?
                        </h2>

                        <p class="to-cta-sub">
                            Set up a workspace in minutes and get your fleet,
                            drivers, and trips on one calm, clear platform today.
                        </p>


                        <div class="to-hero-actions">

                            <a href="~/Guest/SignUp.aspx" runat="server" class="to-btn to-btn-primary to-btn-lg">

                                Get Started Free

                                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">

                                    <path d="M5 12h14" />
                                    <path d="m12 5 7 7-7 7" />

                                </svg>

                            </a>


                            <a href="~/Guest/SignIn.aspx" runat="server" class="to-btn to-btn-light to-btn-lg">
                                Sign In
                            </a>

                        </div>

                    </div>

                </div>

            </section>

        </main>


        <!-- REVEAL ANIMATION SCRIPT -->
        <script>

            (function () {

                var items = document.querySelectorAll('.to-reveal');

                if (!('IntersectionObserver' in window)) {

                    for (var i = 0; i < items.length; i++) {
                        items[i].classList.add('is-visible');
                    }

                    return;
                }

                var observer = new IntersectionObserver(

                    function (entries) {

                        for (var i = 0; i < entries.length; i++) {

                            if (entries[i].isIntersecting) {

                                entries[i].target.classList.add('is-visible');

                                observer.unobserve(entries[i].target);

                            }

                        }

                    },

                    {
                        threshold: 0.15,
                        rootMargin: '0px 0px -40px 0px'
                    }

                );


                for (var j = 0; j < items.length; j++) {
                    observer.observe(items[j]);
                }

            })();

        </script>

    </asp:Content>
