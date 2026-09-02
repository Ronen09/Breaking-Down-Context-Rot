# Task: De-justify the paper's prose (2026-09-02)

User direction:
- Abstract: state experiments ran on OLMo-2-7B-Instruct; summarize what did/didn't reproduce
  on Qwen2.5-7B-Instruct. [DONE]
- Remove argumentative connectives (courtroom tone) -> plain declarative. [DONE]
- Remove ALL \emph in prose (bibliography venue italics kept). [DONE: 77 unwrapped, 0 left
  outside thebibliography]
- Whole paper + appendices; appendices natural prose + display math blocks. [DONE: capture
  softmax row + estimand DiD as display blocks]
- Cut the §2.2 raw-share/goal-accessibility aside; mathematically define the span clamp in
  §2.3 (display equation for clamped weights + odds scaling). [DONE]

## Review
- 0 LaTeX errors, 0 overfull boxes; 22 pages total.
- Page budget: body now ends ~5 lines into page 10 (was exactly 9 pages at HEAD). The added
  abstract sentences + clamp equation cost the slack. Flag to user; compress on request.
- Kept: all numbers/claims/stats parentheticals, \textbf, author's 6 \looseness marks.
- Descriptive ", so " explanations (11 instances) intentionally kept - they report causal
  facts, not argue.

## Round 2 (2026-09-02): defensive positioning, CIs, tables

User feedback: (1) prose was defensively positioned - negative results excused with "we are
not proving that phenomenon"; (2) inline CIs are hard to read; (3) the displacement mass
table made no sense; (4) use percentages for the mass interventions. Reference throughout:
the ICLR 2026 workshop paper `15_Single_Position_Interventio.pdf`, read in full (20pp).

What that paper actually does with uncertainty, and what we adopted:
- CIs appear in exactly two places (headline table + one appendix collection table). Every
  other statistic is a bare point estimate. Figures are for SHAPES (sweeps, thresholds);
  discrete effect sizes with intervals go in tables. There is no forest plot anywhere.
- Tables: one metric column, bold on the number the row exists to show (that is the
  significance flag), prose only in an explicit Note column, one-sentence captions.

Done:
- [x] De-hedged 9 passages (S4.1/4.2/4.3, S6 Limitations, App G/J). Nulls now reported with
      their resolving power instead of defended.
- [x] tab:mass rebuilt in PERCENTAGE POINTS (+15.1 not +0.151), with an "of penalty" column
      in % (91%, 28%). Killed the unclosed-paren caption, the blank grouping cell, and the
      column that mixed numbers with prose.
- [x] tab:fits: 4 causal rows, units in the predictor cell, bold marks intervals excluding
      zero. The observational beta=-11.2 moved back to S4.2 prose as a bare number.
- [x] Table 3 (closures) converted to % mass and points; dissociation prose matched.
- [x] Six inline CIs converted to points and collected in App F tab:intervals.
- [x] S2.3 clamp: dropped the one-use share(A;b) notation for the standard odds form in s.
- [x] S4.5 (the mode) was a 45-line wall of prose carrying 9 separate results. Restructured
      around tab:mode: 9 operations in two labelled blocks (attention to the demonstrated
      answers vs the residual stream), each with outcome + what it shows. Prose cut to two
      paragraphs of interpretation. The table IS the section's argument.
- [x] hidelinks (the red link boxes).
- [x] Reverted the fig_mass_forest experiment entirely (figure, builder, test, numbers.md
      row) once the reference paper showed a table is the right form. No dead code left.

Caught in review:
- S3 claimed "points are the scale of the joint-fit coefficients". False: beta_distance
  = -0.0076 is a FRACTION per turn (x20 turns ~ 15 points, matching the ladder). Corrected.
- A dose-response sentence still cited tab:mass's old fraction scale (0.017); now 1.7 points.

Verification: 0 LaTeX errors, 0 overfull boxes, 0 undefined refs, 0 \emph outside the
bibliography, 0 inline CIs left in body prose. Tests 311 passed / 3 failed, the 3 being
PRE-EXISTING (confirmed by stashing and re-running at HEAD) missing-artifact failures for
`e1_distance_sweep/` and `e1f_share_knee/` documented in docs/ARTIFACTS.md.

## Round 3 (2026-09-02): 9-page budget + precedent section

Body was running 16 lines onto page 10. Target: body ends on p9, References at top of p10
(which is what HEAD did). Restored, with 0 overfull boxes.

- [x] tab:fits (joint fits) moved from body to App F. It cost ~12 body lines to remove 3
      inline CIs; as supporting detail it belongs with the other stats tables, which is also
      where the ICLR reference paper keeps them (its Tables 8-28).
- [x] S4.4 (precedent) restructured around tab:precedent: 11 conditions in 3 labelled blocks
      (no assistant turn / accumulated filler at matched fill / depth-42 reversal), each with
      compliance, accuracy, and what it shows. Prose cut to 3 paragraphs that no longer
      restate the numbers the table carries.
      NOTE: S4.4's figure (fig:erosion) is stranded in App I, which is WHY the section read as
      a wall. Left there for page reasons; moving it into the body would cost ~18 lines.
- [x] Conclusion: dropped 2 citation clauses in the bullets. Every reference removed is still
      cited elsewhere (checked: zhang2023pasta in S2.3, hendel2023taskvectors in S4.5, the
      rest in App A), so no bibliography entry was orphaned.
- [x] Limitations compressed ~35 -> ~20 lines. Cut the closing scope sentence (the abstract
      and S1 both already state the localized-stream scope) and the "unlocalized as a
      direction" clause (tab:mode states it as a row).

One-table-per-section is now the pattern for the three dense results sections: tab:precedent
(4.4), tab:mode (4.5), tab:closures (4.3).

## Round 4: abstract restructured on the reference paper's plan

Their abstract is 222 words to our 387. The gap was hierarchy, not number density (they
actually use MORE numbers than we did). Devices adopted:
- One spine instead of a flat list. Ours was 10 co-equal findings; now the accumulation null
  is the claim and the three mechanisms are its explanation.
- The null promoted, not just reported ("That null is the paper's starting point:").
- Exactly 2 bolded anchors (nothing / 56%), their 0%-vs-96% device.
- Em-dash carrying the prefill-vs-generation dissociation inside one sentence.
- Apparatus demoted: two methodology sentences collapsed into one clause.
- Three paragraphs, so the spine is visible in the layout.

Deliberately NOT adopted: their sell register ("striking", "Crucially", "fundamentally
reshaping our understanding"). Wrong voice for this paper.

387 -> 306 words, 30 -> 27 lines. Claims and numbers unchanged; "bounded nulls" replaced with
the actual bounds (2.9 / 5.5 points), and competition's 8.5 points named in the abstract for
the first time. Still 9 pages.

## Round 5: appendix (no length limit — informativeness over concision)

Modelled on the reference paper's appendix, which is 18 short subsections each with one small
table plus a numbered "Key observations" list, a hyperparameter table (its Table 27), and an
explicit reproducibility section. Ours was long `\paragraph` prose with numbers embedded and
almost no floats: 4 of 10 appendix sections had zero tables or figures.

Added (appendix now 8 tables / 7 figures, up from 5 / 7):
- [x] tab:crossfamily cells are all numeric (user: "numbers instead of flat with fill"); the two rows where the families recorded different statistics are named as such in the caption.
- [x] tab:crossfamily — THE missing table. The Qwen appendix was 186 lines of prose whose one
      job is answering "what replicated?". Now 13 claims x 2 families x verdict, split by a
      rule into the 10 that hold and the 3 competition rows that do not. The competition
      paragraph was then deduped against it and now carries only the masked-channel reading.
- [x] tab:filler — the three filler streams as a spec table (source, demonstrated reply,
      applicability, fill/turn), their Table 8 idiom. Applicability is the design variable and
      was previously buried mid-paragraph.
- [x] tab:config — run configuration in one place (models, seed, decoding, windows, generation
      budgets, bootstrap, share definition, overflow policy), their Table 27 idiom. These were
      scattered across four sections.
- [x] tab:heads — the per-head measurement as displacement vs competition columns, replacing
      a dense 22-line prose block with no float. Added the point that layer 24 is deliberately
      unexceptional, so the readouts are diagnostics rather than a claim about where retrieval
      happens.
- [x] Appendix accuracy contrasts converted to percentage points, matching the body's
      convention (was mixing "9.4 accuracy points" with "+0.026 [-0.042,+0.094]" in one
      sentence).

Body unaffected: still 9 pages, References at the top of page 10.

## Round 6: J.1 (counterfactual patching) + run configuration

- [x] Run configuration reverted from a table to prose (user: a settings list is not a
      comparison). Deduped against the "Probe construction" paragraph directly above it, which
      already carried the probe spec and generation budgets AND their rationale.
- [x] J.1 math written out. Delta-ell was previously never defined - the text said "the two
      instructed formats' teacher-forced log-probability contrast" and left it there. Now:
      Delta-ell(T) = log P(y_A|T) - log P(y_B|T) as a display equation; h_P(T) and T <- h
      defined for the capture-and-splice; the estimand as a labelled difference-in-differences
      with underbraces naming both arms; "share of full" defined as a ratio.
- [x] Cited the method and justified the metric (user request). Added 4 bibitems (also
      mirrored into context_fatigue.bib, 36 -> 40 entries, counts match):
      vig2020mediation + meng2022rome for activation patching in causal-mediation form,
      wang2023ioi for the logit-difference readout, zhang2024patching for the survey of
      patching metrics. Two reasons given for choosing the log-prob difference here: it is
      linear in the logits (a probability readout saturates), and it cancels shifts common to
      both continuations - which matters because the deep code cell runs with the system span
      CLOSED, depressing every well-formed reply at once. A single-format metric would read
      that as an effect.

Verified: 0 errors, 0 overfull, 0 undefined refs, 0 unresolved citations.
