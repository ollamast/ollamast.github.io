<?xml version="1.0" encoding="UTF-8"?>
<!--
  Ollamast-branded sitemap stylesheet.
  Purely cosmetic: crawlers read the raw XML and ignore this XSL.
  Referenced from sitemap.xml via nuxt.config `sitemap.xsl`.
  Kept to XSLT 1.0 (the only version browsers support natively).
-->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:s="http://www.sitemaps.org/schemas/sitemap/0.9"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="s xhtml">

    <xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"
        doctype-system="about:legacy-compat" />

    <xsl:template match="/">
        <html lang="en">
            <head>
                <meta charset="utf-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1" />
                <meta name="robots" content="noindex" />
                <title>Ollamast — XML Sitemap</title>
                <link rel="icon" href="/favicon.ico" />
                <link rel="preconnect" href="https://fonts.googleapis.com" />
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="crossorigin" />
                <link
                    href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@500;600;700&amp;family=Manrope:wght@400;500;600;700&amp;family=JetBrains+Mono:wght@400;500&amp;display=swap"
                    rel="stylesheet" />
                <style>
                    :root {
                        --bg: #06060b;
                        --card: #0d0d18;
                        --fg: #f3f3f7;
                        --muted: rgba(243, 243, 247, 0.6);
                        --faint: rgba(243, 243, 247, 0.38);
                        --acc: #6c5cff;
                        --acc2: #38e0d0;
                        --border: rgba(255, 255, 255, 0.1);
                        --font-heading: 'Space Grotesk', system-ui, sans-serif;
                        --font-sans: 'Manrope', system-ui, sans-serif;
                        --font-mono: 'JetBrains Mono', 'Fira Code', monospace;
                    }

                    * { box-sizing: border-box; }

                    html { scroll-behavior: smooth; }

                    body {
                        margin: 0;
                        min-height: 100vh;
                        background: var(--bg);
                        color: var(--fg);
                        font-family: var(--font-sans);
                        -webkit-font-smoothing: antialiased;
                        text-rendering: optimizeLegibility;
                        line-height: 1.5;
                    }

                    /* Aurora glow — echoes the site's animated background. */
                    .aurora {
                        position: fixed;
                        inset: 0;
                        z-index: 0;
                        pointer-events: none;
                        overflow: hidden;
                    }
                    .aurora::before,
                    .aurora::after {
                        content: '';
                        position: absolute;
                        width: 60vw;
                        height: 60vw;
                        border-radius: 50%;
                        filter: blur(120px);
                        opacity: 0.5;
                    }
                    .aurora::before {
                        top: -20vw;
                        left: -10vw;
                        background: radial-gradient(circle, var(--acc), transparent 65%);
                    }
                    .aurora::after {
                        bottom: -25vw;
                        right: -10vw;
                        background: radial-gradient(circle, var(--acc2), transparent 65%);
                        opacity: 0.32;
                    }

                    .wrap {
                        position: relative;
                        z-index: 1;
                        max-width: 1080px;
                        margin: 0 auto;
                        padding: 56px 24px 80px;
                    }

                    header {
                        display: flex;
                        align-items: center;
                        gap: 16px;
                        margin-bottom: 40px;
                    }
                    header img {
                        width: auto;
                        height: 44px;
                        object-fit: contain;
                        display: block;
                    }
                    .wordmark {
                        font-family: var(--font-heading);
                        font-weight: 700;
                        font-size: 20px;
                        letter-spacing: -0.01em;
                    }
                    .wordmark span { color: var(--acc2); }

                    .eyebrow {
                        font-size: 12px;
                        letter-spacing: 0.18em;
                        text-transform: uppercase;
                        color: var(--acc2);
                        font-weight: 700;
                        margin: 0 0 10px;
                    }
                    h1 {
                        font-family: var(--font-heading);
                        font-weight: 700;
                        font-size: clamp(28px, 4vw, 40px);
                        letter-spacing: -0.02em;
                        margin: 0 0 12px;
                        background: linear-gradient(120deg, var(--fg), var(--acc));
                        -webkit-background-clip: text;
                        background-clip: text;
                        -webkit-text-fill-color: transparent;
                    }
                    .lede {
                        color: var(--muted);
                        max-width: 60ch;
                        margin: 0 0 8px;
                    }
                    .count {
                        display: inline-flex;
                        align-items: center;
                        gap: 8px;
                        margin-top: 18px;
                        padding: 6px 14px;
                        border-radius: 999px;
                        font-family: var(--font-mono);
                        font-size: 13px;
                        color: var(--fg);
                        background: rgba(108, 92, 255, 0.12);
                        border: 1px solid rgba(108, 92, 255, 0.35);
                    }
                    .count b { color: var(--acc2); font-weight: 600; }

                    /* Frosted-glass surface, matching the site's .glass utility. */
                    .card {
                        margin-top: 34px;
                        border-radius: 16px;
                        overflow: hidden;
                        background: linear-gradient(180deg, rgba(255, 255, 255, 0.06), rgba(255, 255, 255, 0.022));
                        border: 1px solid var(--border);
                        box-shadow:
                            inset 0 1px 0 rgba(255, 255, 255, 0.08),
                            0 30px 60px -28px rgba(0, 0, 0, 0.7);
                    }

                    .table-scroll { overflow-x: auto; }

                    table {
                        width: 100%;
                        border-collapse: collapse;
                        font-size: 14px;
                    }
                    thead th {
                        text-align: left;
                        font-family: var(--font-mono);
                        font-weight: 500;
                        font-size: 11px;
                        letter-spacing: 0.12em;
                        text-transform: uppercase;
                        color: var(--faint);
                        padding: 16px 20px;
                        border-bottom: 1px solid var(--border);
                        white-space: nowrap;
                    }
                    tbody td {
                        padding: 14px 20px;
                        border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                        vertical-align: middle;
                    }
                    tbody tr:last-child td { border-bottom: none; }
                    tbody tr { transition: background 0.15s ease; }
                    tbody tr:hover { background: rgba(108, 92, 255, 0.07); }

                    .idx {
                        font-family: var(--font-mono);
                        font-size: 12px;
                        color: var(--faint);
                        width: 1%;
                        white-space: nowrap;
                    }
                    a.loc {
                        color: var(--fg);
                        text-decoration: none;
                        font-weight: 500;
                        border-bottom: 1px solid transparent;
                        transition: color 0.15s ease, border-color 0.15s ease;
                        word-break: break-all;
                    }
                    a.loc:hover {
                        color: var(--acc2);
                        border-color: rgba(56, 224, 208, 0.5);
                    }
                    .meta {
                        font-family: var(--font-mono);
                        font-size: 12.5px;
                        color: var(--muted);
                        white-space: nowrap;
                    }

                    .alts { margin-top: 6px; display: flex; flex-wrap: wrap; gap: 6px; }
                    .alt {
                        font-family: var(--font-mono);
                        font-size: 10.5px;
                        letter-spacing: 0.04em;
                        text-transform: uppercase;
                        color: var(--acc2);
                        padding: 2px 7px;
                        border-radius: 6px;
                        background: rgba(56, 224, 208, 0.1);
                        border: 1px solid rgba(56, 224, 208, 0.25);
                    }

                    /* Priority bar */
                    .prio { display: flex; align-items: center; gap: 8px; }
                    .prio-track {
                        width: 46px;
                        height: 4px;
                        border-radius: 999px;
                        background: rgba(255, 255, 255, 0.1);
                        overflow: hidden;
                    }
                    .prio-fill {
                        height: 100%;
                        border-radius: 999px;
                        background: linear-gradient(90deg, var(--acc), var(--acc2));
                    }

                    footer {
                        margin-top: 28px;
                        color: var(--faint);
                        font-size: 12.5px;
                        line-height: 1.7;
                    }
                    footer code {
                        font-family: var(--font-mono);
                        color: var(--muted);
                        background: rgba(255, 255, 255, 0.06);
                        padding: 1px 6px;
                        border-radius: 5px;
                    }
                    footer a { color: var(--acc2); text-decoration: none; }

                    @media (max-width: 640px) {
                        .wrap { padding: 36px 16px 64px; }
                        thead th, tbody td { padding: 12px 14px; }
                    }
                </style>
            </head>
            <body>
                <div class="aurora"></div>
                <div class="wrap">
                    <header>
                        <img src="/logo.webp" alt="Ollamast" />
                        <div class="wordmark">Ollamast<span> agency</span></div>
                    </header>

                    <!-- Sitemap index (a list of sitemaps) vs. a single URL set. -->
                    <xsl:choose>
                        <xsl:when test="s:sitemapindex">
                            <xsl:call-template name="index" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:call-template name="urlset" />
                        </xsl:otherwise>
                    </xsl:choose>

                    <footer>
                        This styled view is cosmetic — search engines read the raw XML directly.
                        Append <code>?canonical</code> to see the unstyled source.<br />
                        Generated by <a href="https://ollamast.com">Ollamast agency</a>.
                    </footer>
                </div>
            </body>
        </html>
    </xsl:template>

    <!-- ── Single URL set ─────────────────────────────────────────── -->
    <xsl:template name="urlset">
        <p class="eyebrow">XML Sitemap</p>
        <h1>Site URLs</h1>
        <p class="lede">Every indexable page on ollamast.com, with its language
            alternates, last-modified date and crawl priority.</p>
        <div class="count">
            <b><xsl:value-of select="count(s:urlset/s:url)" /></b>
            <xsl:text> URLs in this sitemap</xsl:text>
        </div>

        <div class="card">
            <div class="table-scroll">
                <table>
                    <thead>
                        <tr>
                            <th class="idx">#</th>
                            <th>URL</th>
                            <th>Last modified</th>
                            <th>Priority</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="s:urlset/s:url">
                            <tr>
                                <td class="idx"><xsl:value-of select="position()" /></td>
                                <td>
                                    <a class="loc" href="{s:loc}"><xsl:value-of select="s:loc" /></a>
                                    <xsl:if test="xhtml:link[@rel='alternate']">
                                        <div class="alts">
                                            <xsl:for-each select="xhtml:link[@rel='alternate']">
                                                <span class="alt"><xsl:value-of select="@hreflang" /></span>
                                            </xsl:for-each>
                                        </div>
                                    </xsl:if>
                                </td>
                                <td class="meta">
                                    <xsl:choose>
                                        <xsl:when test="s:lastmod">
                                            <xsl:value-of select="substring(s:lastmod, 1, 10)" />
                                        </xsl:when>
                                        <xsl:otherwise>—</xsl:otherwise>
                                    </xsl:choose>
                                </td>
                                <td>
                                    <xsl:choose>
                                        <xsl:when test="s:priority">
                                            <div class="prio">
                                                <span class="prio-track">
                                                    <span class="prio-fill"
                                                        style="width:{s:priority * 100}%"></span>
                                                </span>
                                                <span class="meta"><xsl:value-of select="s:priority" /></span>
                                            </div>
                                        </xsl:when>
                                        <xsl:otherwise><span class="meta">—</span></xsl:otherwise>
                                    </xsl:choose>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
            </div>
        </div>
    </xsl:template>

    <!-- ── Sitemap index ──────────────────────────────────────────── -->
    <xsl:template name="index">
        <p class="eyebrow">XML Sitemap Index</p>
        <h1>Sitemaps</h1>
        <p class="lede">This index points to the individual sitemaps that make up
            ollamast.com.</p>
        <div class="count">
            <b><xsl:value-of select="count(s:sitemapindex/s:sitemap)" /></b>
            <xsl:text> sitemaps referenced</xsl:text>
        </div>

        <div class="card">
            <div class="table-scroll">
                <table>
                    <thead>
                        <tr>
                            <th class="idx">#</th>
                            <th>Sitemap</th>
                            <th>Last modified</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="s:sitemapindex/s:sitemap">
                            <tr>
                                <td class="idx"><xsl:value-of select="position()" /></td>
                                <td><a class="loc" href="{s:loc}"><xsl:value-of select="s:loc" /></a></td>
                                <td class="meta">
                                    <xsl:choose>
                                        <xsl:when test="s:lastmod">
                                            <xsl:value-of select="substring(s:lastmod, 1, 10)" />
                                        </xsl:when>
                                        <xsl:otherwise>—</xsl:otherwise>
                                    </xsl:choose>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
            </div>
        </div>
    </xsl:template>

</xsl:stylesheet>
