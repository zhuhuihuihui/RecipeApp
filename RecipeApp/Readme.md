### Summary
https://www.dropbox.com/scl/fi/1lt8as8iq86u24870nfs6/Screen-Recording-2025-01-30-at-4.51.37-PM.mov?rlkey=h2onyl7xxjg08l9wrrc36hrpb&dl=0

### Focus Areas
1. Architecture: Implemented strict MVVM pattern for separation of concerns
2. Image Handling: Custom caching solution with memory and disk layers
3. Error Handling: Comprehensive state management for different error scenarios
4. Testability: Protocol-based dependencies for easy mocking

### Time Spent
- 4 hours: Core implementation
- 2 hours: Image caching
- 1.5 hours: Testing
- 0.5 hours: Polish and documentation

### Trade-offs and Decisions
- Used SHA256 for image cache keys instead of URL lastPathComponent
- Simplified error messages for better user experience
- Prioritized memory caching over disk caching for performance

### Weakest Part of the Project
The image caching implementation could be improved with:
- Cache expiration policy
- Background cache cleanup
- Better error handling for corrupted cache files

### Additional Information
- None
