-- ============================================
-- College Campus Connect - Seed Data
-- ============================================
USE college_campus;

-- Sample Users (passwords are hashed 'password123')
INSERT INTO users (name, email, password_hash, avatar, bio, major, year, campus, is_verified) VALUES
('Alex Johnson', 'alex@university.edu', '$2y$12$examplehash1', 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop', 'CS student passionate about AI and startups', 'Computer Science', 'Junior', 'Main Campus', 1),
('Maya Patel', 'maya@university.edu', '$2y$12$examplehash2', 'https://images.unsplash.com/photo-1494790108755-2616b332c36a?w=150&h=150&fit=crop', 'Pre-med with a love for biochemistry research', 'Biology', 'Sophomore', 'Main Campus', 1),
('Jordan Lee', 'jordan@university.edu', '$2y$12$examplehash3', 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=150&h=150&fit=crop', 'Business student and entrepreneur', 'Business Administration', 'Senior', 'Downtown Campus', 1),
('Priya Sharma', 'priya@university.edu', '$2y$12$examplehash4', 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=150&h=150&fit=crop', 'Art & Design student creating digital experiences', 'Graphic Design', 'Junior', 'Main Campus', 0),
('Carlos Rivera', 'carlos@university.edu', '$2y$12$examplehash5', 'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=150&h=150&fit=crop', 'Engineering student & robotics club president', 'Mechanical Engineering', 'Senior', 'Engineering Campus', 1);

-- Sample Clubs
INSERT INTO clubs (name, description, category, president_id, members_count, is_official) VALUES
('Tech Innovators Club', 'Building the future with code, hardware, and entrepreneurial thinking.', 'Technology', 1, 142, 1),
('Pre-Med Society', 'Preparing future healthcare leaders through mentorship and research.', 'Academic', 2, 98, 1),
('Entrepreneurship Hub', 'Connect, pitch, and grow your startup ideas on campus.', 'Business', 3, 75, 1),
('Creative Arts Collective', 'A space for artists, designers, photographers, and creatives.', 'Arts', 4, 63, 0),
('Robotics & AI Club', 'Engineering the future with intelligent machines.', 'Technology', 5, 110, 1),
('Campus Green Initiative', 'Making our campus and community more sustainable.', 'Environment', 1, 89, 1);

-- Sample Events
INSERT INTO events (title, description, location, start_datetime, end_datetime, organizer_id, event_type, attendees_count, is_free) VALUES
('Spring Tech Hackathon 2025', '48-hour hackathon to solve real campus problems. Form teams, build fast, win prizes!', 'Engineering Hall, Room 201', '2025-04-12 09:00:00', '2025-04-14 18:00:00', 1, 'academic', 180, 1),
('Campus Career Fair', 'Meet 50+ employers from tech, finance, healthcare & more. Bring your resume!', 'Student Union Ballroom', '2025-04-20 10:00:00', '2025-04-20 17:00:00', 3, 'career', 450, 1),
('Mental Wellness Week Kickoff', 'Opening ceremony for campus mental health awareness week featuring workshops.', 'Campus Quad', '2025-04-15 14:00:00', '2025-04-15 16:00:00', 2, 'social', 200, 1),
('Spring Music Festival', 'Live performances by student bands and artists. Food trucks, vendors & fun!', 'Amphitheater', '2025-04-18 17:00:00', '2025-04-18 22:00:00', 4, 'arts', 600, 1),
('Robotics Demo Day', 'Watch teams showcase their semester-long robotics projects live!', 'Engineering Lab B', '2025-04-22 13:00:00', '2025-04-22 16:00:00', 5, 'academic', 120, 1);

-- Sample Posts
INSERT INTO posts (user_id, content, post_type, likes_count, comments_count) VALUES
(1, '🚀 Just got accepted into the Google Summer of Code program! Hard work really pays off. Huge thanks to the Tech Innovators Club for all the support and mock interviews. If anyone needs help applying next year, hit me up! #GSoC #OpenSource #CampusLife', 'general', 87, 23),
(2, '📚 Study tip that changed my life: the Pomodoro Technique + background lo-fi music = unstoppable. 25 min focus, 5 min break. Try it for finals week. Also forming a Bio study group for the midterm next Friday — DM me if interested!', 'study', 64, 18),
(3, '🎉 BIG NEWS: Our campus startup "EcoRide" just closed its first seed round! We''re building sustainable campus transportation and we''re LIVE. Check us out and support student entrepreneurs! #StartupLife #Entrepreneurship', 'announcement', 112, 45),
(4, '🎨 Just finished my senior thesis project — a digital mural celebrating campus diversity. 3 weeks, 200+ reference photos, countless iterations. Presenting Friday in the Art Gallery if you want to come!', 'general', 93, 31),
(5, '🤖 Our robotics team just won FIRST place at the Regional Autonomous Vehicle Competition! Absolutely incredible. 6 months of late nights in the lab paid off big time. Thank you @AlexJohnson for the AI algorithm help!', 'announcement', 156, 52);

-- Study Groups
INSERT INTO study_groups (name, course_code, subject, creator_id, members_count, meeting_time, location, is_open) VALUES
('CS301 Algorithm Prep', 'CS301', 'Data Structures & Algorithms', 1, 6, 'Tuesdays & Thursdays 7-9 PM', 'Library Room 3B', 1),
('Bio202 Midterm Crew', 'BIO202', 'Molecular Biology', 2, 5, 'Mondays 6-8 PM', 'Science Building Lounge', 1),
('Calc III Study Squad', 'MATH301', 'Multivariable Calculus', 3, 4, 'Weekends 2-4 PM', 'Math Building 105', 1),
('Organic Chem Survivors', 'CHEM301', 'Organic Chemistry', 2, 7, 'Wednesdays 5-7 PM', 'Chemistry Lab Lobby', 0);
