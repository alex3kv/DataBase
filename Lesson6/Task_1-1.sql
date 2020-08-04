-- Создать все необходимые внешние ключи и диаграмму отношений.

-- связь profiles на users
ALTER TABLE profiles 
  ADD CONSTRAINT FK_profiles_users_id FOREIGN KEY (user_id)
    REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE;

-- связь media на users
ALTER TABLE media 
  ADD CONSTRAINT FK_media_users_id FOREIGN KEY (user_id)
    REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE;

-- связь media на media_types
ALTER TABLE media 
  ADD CONSTRAINT FK_media_media_types_id FOREIGN KEY (media_type_id)
    REFERENCES media_types(id) ON DELETE CASCADE ON UPDATE CASCADE;

-- связь profiles на media
ALTER TABLE profiles 
  ADD CONSTRAINT FK_profiles_media_id FOREIGN KEY (photo_id)
    REFERENCES media(id) ON DELETE SET NULL ON UPDATE set NULL;

-- связь messages from на users
ALTER TABLE messages 
  ADD CONSTRAINT FK_messages_from_users_id FOREIGN KEY (from_user_id)
    REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE;

-- связь messages to на users
ALTER TABLE messages 
  ADD CONSTRAINT FK_messages_to_users_id FOREIGN KEY (to_user_id)
    REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE;

-- связь friendship на friendship_statuses
ALTER TABLE friendship 
  ADD CONSTRAINT FK_friendship_friendship_statuses_id FOREIGN KEY (status_id)
    REFERENCES friendship_statuses(id);

-- связь friendship на users
ALTER TABLE friendship 
  ADD CONSTRAINT FK_friendship_users_id FOREIGN KEY (user_id)
    REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE;

-- связь friendship на friend users
ALTER TABLE friendship 
  ADD CONSTRAINT FK_friendship_friend_users_id FOREIGN KEY (friend_id)
    REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE;

-- связь friendship_history на friendship
ALTER TABLE friendship_history 
  ADD CONSTRAINT FK_friendship_history_friendship_id FOREIGN KEY (friendship_id)
    REFERENCES friendship(id) ON DELETE CASCADE ON UPDATE CASCADE;

-- связь friendship_history на friendship_statuses
ALTER TABLE friendship_history 
  ADD CONSTRAINT FK_friendship_history_friendship_statuses_id FOREIGN KEY (status_id)
    REFERENCES friendship_statuses(id);

-- связь communities_users на users
ALTER TABLE communities_users 
  ADD CONSTRAINT FK_communities_users_users_id FOREIGN KEY (user_id)
    REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE;

-- связь communities_users на communities
ALTER TABLE communities_users 
  ADD CONSTRAINT FK_communities_users_communities_id FOREIGN KEY (community_id)
    REFERENCES communities(id) ON DELETE CASCADE ON UPDATE CASCADE;

-- связь likes на target_types
ALTER TABLE likes 
  ADD CONSTRAINT FK_likes_target_types_id FOREIGN KEY (target_type_id)
    REFERENCES target_types(id) ON DELETE CASCADE ON UPDATE CASCADE;

-- связь likes на users
ALTER TABLE likes 
  ADD CONSTRAINT FK_likes_users_id FOREIGN KEY (user_id)
    REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE;

-- связь posts на users
ALTER TABLE posts 
  ADD CONSTRAINT FK_posts_users_id FOREIGN KEY (user_id)
    REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE;

-- связь posts на communities
ALTER TABLE posts 
  ADD CONSTRAINT FK_posts_communities_id FOREIGN KEY (community_id)
    REFERENCES communities(id) ON DELETE CASCADE ON UPDATE CASCADE;

-- связь posts на media
ALTER TABLE posts 
  ADD CONSTRAINT FK_posts_media_id FOREIGN KEY (media_id)
    REFERENCES media(id) ON DELETE CASCADE ON UPDATE CASCADE;