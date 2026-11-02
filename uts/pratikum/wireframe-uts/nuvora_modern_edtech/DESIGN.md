---
name: Nuvora Modern EdTech
colors:
  surface: '#f9f9ff'
  surface-dim: '#cfdaf2'
  surface-bright: '#f9f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f0f3ff'
  surface-container: '#e7eeff'
  surface-container-high: '#dee8ff'
  surface-container-highest: '#d8e3fb'
  on-surface: '#111c2d'
  on-surface-variant: '#444655'
  inverse-surface: '#263143'
  inverse-on-surface: '#ecf1ff'
  outline: '#747686'
  outline-variant: '#c4c5d7'
  surface-tint: '#2e4edc'
  primary: '#2346d5'
  on-primary: '#ffffff'
  primary-container: '#4361ee'
  on-primary-container: '#f4f2ff'
  inverse-primary: '#bac3ff'
  secondary: '#006c4f'
  on-secondary: '#ffffff'
  secondary-container: '#51fac1'
  on-secondary-container: '#007152'
  tertiary: '#735000'
  on-tertiary: '#ffffff'
  tertiary-container: '#926700'
  on-tertiary-container: '#fff1e0'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#dee1ff'
  primary-fixed-dim: '#bac3ff'
  on-primary-fixed: '#001159'
  on-primary-fixed-variant: '#0031c4'
  secondary-fixed: '#54fdc4'
  secondary-fixed-dim: '#27e0a9'
  on-secondary-fixed: '#002116'
  on-secondary-fixed-variant: '#00513b'
  tertiary-fixed: '#ffdea9'
  tertiary-fixed-dim: '#ffba27'
  on-tertiary-fixed: '#271900'
  on-tertiary-fixed-variant: '#5e4100'
  background: '#f9f9ff'
  on-background: '#111c2d'
  surface-variant: '#d8e3fb'
typography:
  headline-xl:
    fontFamily: Plus Jakarta Sans
    fontSize: 32px
    fontWeight: '800'
    lineHeight: 40px
  headline-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 24px
    fontWeight: '700'
    lineHeight: 32px
  headline-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 20px
    fontWeight: '700'
    lineHeight: 28px
  headline-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 18px
    fontWeight: '600'
    lineHeight: 24px
  body-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 16px
    fontWeight: '500'
    lineHeight: 24px
  body-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  body-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 12px
    fontWeight: '400'
    lineHeight: 18px
  label-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
  label-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
  label-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 11px
    fontWeight: '700'
    lineHeight: 14px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  gutter: 1rem
  margin: 1.25rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 1rem
  space-lg: 1.5rem
  space-xl: 2rem
---

## Brand & Style

The design system is crafted for a dual-experience learning platform that caters symmetrically to students and educators. The emotional objective is to make daily academic routines feel light, organized, and encouraging—eradicating the intimidation often associated with homework deadlines, grading, and course navigation.

### Visual Aesthetic
- **Style Archetype:** Modern Friendly Minimalist with subtle tactile elevation. It pairs expansive soft white surfaces with vibrant primary and contextual semantic tones.
- **Tone & Voice:** Energetic, supportive, structured, and modern. Interactivity is signaled through smooth state transitions and soft radii rather than harsh borders or high-friction modal dialogues.
- **Role Differentiation:** Both interfaces share foundational ergonomics (navigation bars, typography, structural cards), but diverge softly through contextual accents: Student interfaces focus on personal milestone rewards, schedule clarity, and completion motivation; Teacher interfaces emphasize rapid operational triage, bulk status reviews, and publishing controls.

## Colors

The palette is engineered around high readability and intuitive contextual feedback across mobile canvases.

### Primary & Brand Accents
- **Primary (`#4361EE`):** The signature vibrant royal blue driving prominent navigation items, active tab highlights, primary actions, and hero banner cards.
- **Secondary (`#06D6A0`):** Fresh mint/cyan used for successful completion states, score indicators (grades above benchmark), and progress satisfaction.
- **Tertiary (`#FFB703`):** Radiant amber/orange used strictly for upcoming deadline badges, urgent reminder pins, and active quiz warnings.

### Feedback & Semantic State Colors
- **Destructive / Late State (`#EF4444`):** Clear crimson reserved for overdue assignments, expired submissions, and destructive confirmation triggers.
- **Info / Pending Slate (`#6366F1`):** Soft indigo used for secondary informational pills and neutral notifications.

### Neutral Layering Hierarchy
- **Canvas Base (`#F8FAFC`):** Soft, non-glare off-white delivering high contrast against primary cards.
- **Card Surface (`#FFFFFF`):** Crisp pure white applied to elevated lists, interactive modules, and sheets.
- **Text Primary (`#0F172A`):** High-density slate for titles and active numerical grades.
- **Text Secondary (`#64748B`):** Muted cool gray for metadata, timestamps, and secondary labels.
- **Border / Divider (`#F1F5F9`):** Ghost strokes preventing visual noise while framing modular inputs.

## Typography

The typography scale utilizes **Plus Jakarta Sans** uniformly across headlines, reading text, and compact UI chips. Its contemporary geometric geometry with wide letter apertures guarantees immediate legibility even on compact mobile viewports.

- **Headlines (`headline-xl` down to `headline-sm`):** Rendered with weight `700` and `800` to anchor screen hierarchies such as user greetings ("Halo, Andi 👋") and class subject banners.
- **Body (`body-lg`, `body-md`, `body-sm`):** Tuned with comfortable line-heights to support reading assignment instructions, multi-line questions, and notification descriptions without eye strain.
- **Labels & Badges (`label-lg`, `label-md`, `label-sm`):** Weighted at `600` and `700` with tight vertical metrics, specialized for deadline chips, score badges, and action button labels.

## Layout & Spacing

The layout model is anchored on an 8pt incremental spacing system calibrated for high-efficiency mobile application viewports (360px–430px standard screen widths).

### Spatial Rhythm
- **Outer Canvas Margins (`margin` = 20px / 1.25rem):** Maintains breathing room along the device edges, preventing accidental gesture triggers while maximizing thumb reach.
- **Component Padding:** Standard card bodies apply `space-md` (16px) internally, while condensed status chips and notification rows leverage `space-xs` (4px) to `space-sm` (8px).
- **Stack Gaps:** Vertical lists between distinct classroom units, pending assignments, or summary modules use `space-md` (16px). Major contextual sections (e.g., separating "Tugas Terdekat" from "Kelas Aktif") enforce `space-lg` (24px).
- **Navigation Anchors:** Bottom navigation bars feature 64px fixed heights with centered icon-label pairs, padded safely above iOS and Android system gesture strips.

## Elevation & Depth

Visual hierarchy is constructed through soft, ambient multi-stop drop shadows and chromatic overlays, rejecting heavy outlines.

### Elevation Hierarchy
- **Level 0 (Flat / Canvas):** Applied to the base canvas background (`#F8FAFC`). No shadow.
- **Level 1 (Card & Content Blocks):** Soft ambient diffusion applied to standard course cards and assignment items:
  `box-shadow: 0px 4px 16px -2px rgba(30, 41, 59, 0.05), 0px 2px 6px -1px rgba(30, 41, 59, 0.03);`
- **Level 2 (Floating Action Buttons & Bottom Navigation):** Raised interactive layers providing strong tactile distinction:
  `box-shadow: 0px 8px 24px -4px rgba(67, 97, 238, 0.18), 0px 4px 12px -2px rgba(30, 41, 59, 0.06);`
- **Level 3 (Modal Sheets & Prompts):** Deep blurred backdrop scrim with soft high-radius shadow for quiz submission modals and status confirmation sheets:
  `box-shadow: 0px 20px 32px -8px rgba(15, 23, 42, 0.14);`

### Border Accents
Cards remain predominantly borderless or utilize a subtle hairline stroke (`1px solid #F1F5F9`) to define card perimeters against white canvas portions.

## Shapes

The design system employs a distinctly modern, curvilinear geometry centered around `rounded-xl` and `rounded-2xl` scales to impart a playful, welcoming educational atmosphere.

### Radius Assignments
- **Micro Radii (`rounded-sm` / 6px):** Checkbox indicators and micro step progress ticks.
- **Medium Radii (`rounded-lg` / 12px):** Form input text fields, select menus, and square subject icon containers.
- **Large Radii (`rounded-xl` / 16px):** Assignment cards, quiz choice options, and secondary action wrappers.
- **Super Radii (`rounded-2xl` / 24px):** Primary hero banners (e.g., student greeting banners, teacher activity summaries) and bottom sheet top edges.
- **Full Pill (`rounded-full` / 9999px):** Status chips ("Dikumpulkan", "Belum", "Terlambat"), filter pills, avatars, and primary action buttons.

## Components

### Buttons
- **Primary Buttons:** Saturated `#4361EE` fill with pure white label (`label-lg`), height of 48px to 52px, full pill shape (`rounded-full` or `rounded-xl`), soft blue glow elevation. Active feedback uses a subtle scale down (`scale(0.98)`).
- **Secondary / Ghost Buttons:** Soft primary tint background (`rgba(67, 97, 238, 0.08)`) with `#4361EE` typography, zero elevation.
- **Destructive Buttons:** Soft coral background with `#EF4444` foreground, used for sign-out or submission cancellation triggers.

### Status Chips & Pills
- **Pill Badge Specifications:** Strict height of 24px to 28px, padding `4px 12px`, typography `label-sm`.
- **Submitted / Finished:** Mint green background (`#E6FBF5`), dark green text (`#059669`).
- **Pending / Upcoming Deadline:** Light orange/amber background (`#FEF3C7`), amber text (`#D97706`).
- **Late / Overdue:** Pale red background (`#FEE2E2`), crimson text (`#DC2626`).

### Assignment & Class Cards
- Surface background is crisp white (`#FFFFFF`) with Level 1 elevation and `rounded-xl` (16px) corners.
- Left-aligned icon wrapper features an icon container (44x44px, `rounded-xl`) with subject-coded pastel fills (e.g., sky blue for Math, soft purple for Informatics, warm yellow for Indonesian).
- Right-aligned trailing elements house status pills, score counters, or navigation chevron arrows.

### Form Inputs & Search Fields
- Enclosed with a light grey fill (`#F8FAFC`) and 1px border (`#E2E8F0`).
- Padding is 14px horizontal and 12px vertical with `rounded-xl` borders.
- Focused state transitions border to `#4361EE` with a 3px soft outer focus ring (`rgba(67, 97, 238, 0.15)`).

### Subject Stat Counters (Teacher Dashboard)
- Compact, multi-column metric boxes with `rounded-xl` corners displaying active classes, submitted tasks, and pending reviews.
- Number values are emphasized via `headline-lg` with contextual soft color accents behind each value.