# Smart Bins Management System Plan

## Overview
A warehouse-style smart parts bin management system with AI identification and image galleries.

## Features
- [x] Generate Phoenix LiveView project `smart_bins`
- [ ] Add required dependencies (AWS S3, OpenAI API)
- [ ] Start server and replace home page with warehouse-style static mockup
- [ ] Create database schema (2 steps)
  - Bins table (container_id, bin_id, description, ai_description, thumbnail_url, etc)
  - Tags table with many-to-many relationship to bins
- [ ] Implement AWS S3 integration for image fetching
- [ ] Implement OpenAI Vision API for content identification
- [ ] Create main BinsLive LiveView with real-time updates
  - Data-dense table view of all bins
  - Image gallery that updates as you scroll through bins
  - Efficient scanning interface
- [ ] Create bin management LiveComponents
  - Add/edit bin form component
  - Tag management component
- [ ] Style layouts for warehouse management aesthetic
  - Industrial color scheme (grays, blues, minimal accents)
  - Dense information display
  - Quick scanning optimized
- [ ] Add routes and test complete functionality
- [ ] Visit running app to verify everything works

## Technical Details
- Container/Bin ID format: `container.bin` (e.g., `1.24`, `2.15`)
- AWS S3 structure: `/{container_id}/{bin_id}/index.png` for thumbnails
- OpenAI Vision API for AI content identification
- LiveView streams for efficient bin listing
- Real-time image gallery updates without user interaction

Total estimated: 14-16 steps with 2 reserved for debugging
