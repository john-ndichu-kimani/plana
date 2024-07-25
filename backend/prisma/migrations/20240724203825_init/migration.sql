BEGIN TRY

BEGIN TRAN;

-- CreateTable
CREATE TABLE [dbo].[User] (
    [user_id] NVARCHAR(1000) NOT NULL,
    [username] NVARCHAR(1000) NOT NULL,
    [email] NVARCHAR(1000) NOT NULL,
    [password_hash] NVARCHAR(1000) NOT NULL,
    [role] NVARCHAR(1000) NOT NULL CONSTRAINT [User_role_df] DEFAULT 'attendee',
    [first_name] NVARCHAR(1000) NOT NULL,
    [last_name] NVARCHAR(1000) NOT NULL,
    [phone_number] NVARCHAR(1000) NOT NULL,
    [profile_picture_url] NVARCHAR(1000),
    [is_deleted] BIT NOT NULL CONSTRAINT [User_is_deleted_df] DEFAULT 0,
    [created_at] DATETIME2 NOT NULL CONSTRAINT [User_created_at_df] DEFAULT CURRENT_TIMESTAMP,
    [updated_at] DATETIME2 NOT NULL,
    CONSTRAINT [User_pkey] PRIMARY KEY CLUSTERED ([user_id]),
    CONSTRAINT [User_username_key] UNIQUE NONCLUSTERED ([username]),
    CONSTRAINT [User_email_key] UNIQUE NONCLUSTERED ([email])
);

-- CreateTable
CREATE TABLE [dbo].[Event] (
    [event_id] NVARCHAR(1000) NOT NULL,
    [title] NVARCHAR(1000) NOT NULL,
    [description] NVARCHAR(1000) NOT NULL,
    [date] DATETIME2 NOT NULL,
    [time] DATETIME2 NOT NULL,
    [location] NVARCHAR(1000) NOT NULL,
    [images] NVARCHAR(1000),
    [created_by] NVARCHAR(1000) NOT NULL,
    [created_at] DATETIME2 NOT NULL CONSTRAINT [Event_created_at_df] DEFAULT CURRENT_TIMESTAMP,
    [updated_at] DATETIME2 NOT NULL,
    [capacity] INT NOT NULL,
    [max_group_size] INT,
    [available_slots] INT NOT NULL,
    [ticket_price] FLOAT(53) NOT NULL CONSTRAINT [Event_ticket_price_df] DEFAULT 0,
    [status] NVARCHAR(1000) NOT NULL CONSTRAINT [Event_status_df] DEFAULT 'Pending',
    [is_deleted] BIT NOT NULL CONSTRAINT [Event_is_deleted_df] DEFAULT 0,
    CONSTRAINT [Event_pkey] PRIMARY KEY CLUSTERED ([event_id])
);

-- CreateTable
CREATE TABLE [dbo].[Ticket] (
    [ticket_id] NVARCHAR(1000) NOT NULL,
    [event_id] NVARCHAR(1000) NOT NULL,
    [user_id] NVARCHAR(1000) NOT NULL,
    [image] NVARCHAR(1000),
    [booking_status] NVARCHAR(1000) NOT NULL CONSTRAINT [Ticket_booking_status_df] DEFAULT 'pending',
    [booking_date] DATETIME2 NOT NULL CONSTRAINT [Ticket_booking_date_df] DEFAULT CURRENT_TIMESTAMP,
    [price] FLOAT(53) NOT NULL,
    [group_size] INT,
    [is_deleted] BIT NOT NULL CONSTRAINT [Ticket_is_deleted_df] DEFAULT 0,
    CONSTRAINT [Ticket_pkey] PRIMARY KEY CLUSTERED ([ticket_id])
);

-- CreateTable
CREATE TABLE [dbo].[EventAttendee] (
    [attendee_id] NVARCHAR(1000) NOT NULL,
    [event_id] NVARCHAR(1000) NOT NULL,
    [user_id] NVARCHAR(1000) NOT NULL,
    [booking_status] NVARCHAR(1000) NOT NULL CONSTRAINT [EventAttendee_booking_status_df] DEFAULT 'confirmed',
    [booking_date] DATETIME2 NOT NULL CONSTRAINT [EventAttendee_booking_date_df] DEFAULT CURRENT_TIMESTAMP,
    [ticket_id] NVARCHAR(1000) NOT NULL,
    [is_deleted] BIT NOT NULL CONSTRAINT [EventAttendee_is_deleted_df] DEFAULT 0,
    CONSTRAINT [EventAttendee_pkey] PRIMARY KEY CLUSTERED ([attendee_id])
);

-- CreateTable
CREATE TABLE [dbo].[Notification] (
    [notification_id] NVARCHAR(1000) NOT NULL,
    [recipient_id] NVARCHAR(1000) NOT NULL,
    [event_id] NVARCHAR(1000),
    [message] NVARCHAR(1000) NOT NULL,
    [sent_at] DATETIME2 NOT NULL CONSTRAINT [Notification_sent_at_df] DEFAULT CURRENT_TIMESTAMP,
    [notification_type] NVARCHAR(1000) NOT NULL CONSTRAINT [Notification_notification_type_df] DEFAULT 'email',
    [is_deleted] BIT NOT NULL CONSTRAINT [Notification_is_deleted_df] DEFAULT 0,
    CONSTRAINT [Notification_pkey] PRIMARY KEY CLUSTERED ([notification_id])
);

-- CreateTable
CREATE TABLE [dbo].[UserRole] (
    [role_id] NVARCHAR(1000) NOT NULL,
    [role_name] NVARCHAR(1000) NOT NULL,
    [description] NVARCHAR(1000) NOT NULL,
    CONSTRAINT [UserRole_pkey] PRIMARY KEY CLUSTERED ([role_id]),
    CONSTRAINT [UserRole_role_name_key] UNIQUE NONCLUSTERED ([role_name])
);

-- CreateTable
CREATE TABLE [dbo].[EventStatistic] (
    [statistic_id] NVARCHAR(1000) NOT NULL,
    [event_id] NVARCHAR(1000) NOT NULL,
    [total_attendees] INT NOT NULL,
    [total_revenue] FLOAT(53) NOT NULL,
    [created_at] DATETIME2 NOT NULL CONSTRAINT [EventStatistic_created_at_df] DEFAULT CURRENT_TIMESTAMP,
    [updated_at] DATETIME2 NOT NULL,
    [is_deleted] BIT NOT NULL CONSTRAINT [EventStatistic_is_deleted_df] DEFAULT 0,
    CONSTRAINT [EventStatistic_pkey] PRIMARY KEY CLUSTERED ([statistic_id]),
    CONSTRAINT [EventStatistic_event_id_key] UNIQUE NONCLUSTERED ([event_id])
);

-- CreateTable
CREATE TABLE [dbo].[UserProfile] (
    [user_id] NVARCHAR(1000) NOT NULL,
    [first_name] NVARCHAR(1000) NOT NULL,
    [last_name] NVARCHAR(1000) NOT NULL,
    [email] NVARCHAR(1000) NOT NULL,
    [phone_number] NVARCHAR(1000) NOT NULL,
    [profile_picture_url] NVARCHAR(1000),
    [created_at] DATETIME2 NOT NULL CONSTRAINT [UserProfile_created_at_df] DEFAULT CURRENT_TIMESTAMP,
    [updated_at] DATETIME2 NOT NULL CONSTRAINT [UserProfile_updated_at_df] DEFAULT CURRENT_TIMESTAMP,
    [is_deleted] BIT NOT NULL CONSTRAINT [UserProfile_is_deleted_df] DEFAULT 0,
    CONSTRAINT [UserProfile_pkey] PRIMARY KEY CLUSTERED ([user_id])
);

-- CreateTable
CREATE TABLE [dbo].[BookingHistory] (
    [history_id] NVARCHAR(1000) NOT NULL,
    [user_id] NVARCHAR(1000) NOT NULL,
    [event_id] NVARCHAR(1000) NOT NULL,
    [ticket_id] NVARCHAR(1000) NOT NULL,
    [booking_date] DATETIME2 NOT NULL CONSTRAINT [BookingHistory_booking_date_df] DEFAULT CURRENT_TIMESTAMP,
    [status] NVARCHAR(1000) NOT NULL CONSTRAINT [BookingHistory_status_df] DEFAULT 'booked',
    [is_deleted] BIT NOT NULL CONSTRAINT [BookingHistory_is_deleted_df] DEFAULT 0,
    CONSTRAINT [BookingHistory_pkey] PRIMARY KEY CLUSTERED ([history_id])
);

-- CreateTable
CREATE TABLE [dbo].[Permission] (
    [permission_id] NVARCHAR(1000) NOT NULL,
    [role_id] NVARCHAR(1000) NOT NULL,
    [permission_name] NVARCHAR(1000) NOT NULL,
    [description] NVARCHAR(1000) NOT NULL,
    [is_deleted] BIT NOT NULL CONSTRAINT [Permission_is_deleted_df] DEFAULT 0,
    CONSTRAINT [Permission_pkey] PRIMARY KEY CLUSTERED ([permission_id])
);

-- CreateTable
CREATE TABLE [dbo].[EventApproval] (
    [approval_id] NVARCHAR(1000) NOT NULL,
    [event_id] NVARCHAR(1000) NOT NULL,
    [approved_by] NVARCHAR(1000) NOT NULL,
    [approval_status] NVARCHAR(1000) NOT NULL CONSTRAINT [EventApproval_approval_status_df] DEFAULT 'pending',
    [approval_date] DATETIME2 NOT NULL CONSTRAINT [EventApproval_approval_date_df] DEFAULT CURRENT_TIMESTAMP,
    [is_deleted] BIT NOT NULL CONSTRAINT [EventApproval_is_deleted_df] DEFAULT 0,
    CONSTRAINT [EventApproval_pkey] PRIMARY KEY CLUSTERED ([approval_id])
);

-- CreateTable
CREATE TABLE [dbo].[Report] (
    [report_id] NVARCHAR(1000) NOT NULL,
    [generated_by] NVARCHAR(1000) NOT NULL,
    [report_type] NVARCHAR(1000) NOT NULL,
    [report_data] NVARCHAR(1000) NOT NULL,
    [created_at] DATETIME2 NOT NULL CONSTRAINT [Report_created_at_df] DEFAULT CURRENT_TIMESTAMP,
    [is_deleted] BIT NOT NULL CONSTRAINT [Report_is_deleted_df] DEFAULT 0,
    CONSTRAINT [Report_pkey] PRIMARY KEY CLUSTERED ([report_id])
);

-- CreateTable
CREATE TABLE [dbo].[PasswordResetToken] (
    [id] NVARCHAR(1000) NOT NULL,
    [user_id] NVARCHAR(1000) NOT NULL,
    [reset_code] NVARCHAR(1000) NOT NULL,
    [is_valid] BIT NOT NULL CONSTRAINT [PasswordResetToken_is_valid_df] DEFAULT 1,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [PasswordResetToken_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    [expires_at] DATETIME2 NOT NULL,
    CONSTRAINT [PasswordResetToken_pkey] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[ManagerRequest] (
    [request_id] NVARCHAR(1000) NOT NULL,
    [user_id] NVARCHAR(1000) NOT NULL,
    [status] NVARCHAR(1000) NOT NULL CONSTRAINT [ManagerRequest_status_df] DEFAULT 'pending',
    [requested_at] DATETIME2 NOT NULL CONSTRAINT [ManagerRequest_requested_at_df] DEFAULT CURRENT_TIMESTAMP,
    [approved_at] DATETIME2,
    [rejected_at] DATETIME2,
    CONSTRAINT [ManagerRequest_pkey] PRIMARY KEY CLUSTERED ([request_id])
);

-- CreateTable
CREATE TABLE [dbo].[ChatRoom] (
    [chat_room_id] NVARCHAR(1000) NOT NULL,
    [name] NVARCHAR(1000),
    [created_at] DATETIME2 NOT NULL CONSTRAINT [ChatRoom_created_at_df] DEFAULT CURRENT_TIMESTAMP,
    [updated_at] DATETIME2 NOT NULL,
    [event_id] NVARCHAR(1000),
    CONSTRAINT [ChatRoom_pkey] PRIMARY KEY CLUSTERED ([chat_room_id])
);

-- CreateTable
CREATE TABLE [dbo].[Message] (
    [message_id] NVARCHAR(1000) NOT NULL,
    [chat_room_id] NVARCHAR(1000) NOT NULL,
    [sender_id] NVARCHAR(1000) NOT NULL,
    [content] NVARCHAR(1000) NOT NULL,
    [created_at] DATETIME2 NOT NULL CONSTRAINT [Message_created_at_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [Message_pkey] PRIMARY KEY CLUSTERED ([message_id])
);

-- CreateTable
CREATE TABLE [dbo].[Participant] (
    [participant_id] NVARCHAR(1000) NOT NULL,
    [chat_room_id] NVARCHAR(1000) NOT NULL,
    [user_id] NVARCHAR(1000) NOT NULL,
    [joined_at] DATETIME2 NOT NULL CONSTRAINT [Participant_joined_at_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [Participant_pkey] PRIMARY KEY CLUSTERED ([participant_id])
);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Ticket_event_id_idx] ON [dbo].[Ticket]([event_id]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Ticket_user_id_idx] ON [dbo].[Ticket]([user_id]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EventAttendee_event_id_idx] ON [dbo].[EventAttendee]([event_id]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EventAttendee_user_id_idx] ON [dbo].[EventAttendee]([user_id]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EventAttendee_ticket_id_idx] ON [dbo].[EventAttendee]([ticket_id]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Notification_recipient_id_idx] ON [dbo].[Notification]([recipient_id]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Notification_event_id_idx] ON [dbo].[Notification]([event_id]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [UserRole_role_name_idx] ON [dbo].[UserRole]([role_name]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EventStatistic_event_id_idx] ON [dbo].[EventStatistic]([event_id]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [UserProfile_user_id_idx] ON [dbo].[UserProfile]([user_id]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [BookingHistory_user_id_idx] ON [dbo].[BookingHistory]([user_id]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [BookingHistory_event_id_idx] ON [dbo].[BookingHistory]([event_id]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [BookingHistory_ticket_id_idx] ON [dbo].[BookingHistory]([ticket_id]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Permission_role_id_idx] ON [dbo].[Permission]([role_id]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EventApproval_event_id_idx] ON [dbo].[EventApproval]([event_id]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [EventApproval_approved_by_idx] ON [dbo].[EventApproval]([approved_by]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Report_generated_by_idx] ON [dbo].[Report]([generated_by]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [PasswordResetToken_user_id_idx] ON [dbo].[PasswordResetToken]([user_id]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ManagerRequest_user_id_idx] ON [dbo].[ManagerRequest]([user_id]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ChatRoom_event_id_idx] ON [dbo].[ChatRoom]([event_id]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Message_chat_room_id_idx] ON [dbo].[Message]([chat_room_id]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Message_sender_id_idx] ON [dbo].[Message]([sender_id]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Participant_chat_room_id_idx] ON [dbo].[Participant]([chat_room_id]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Participant_user_id_idx] ON [dbo].[Participant]([user_id]);

-- AddForeignKey
ALTER TABLE [dbo].[Event] ADD CONSTRAINT [Event_created_by_fkey] FOREIGN KEY ([created_by]) REFERENCES [dbo].[User]([user_id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Ticket] ADD CONSTRAINT [Ticket_event_id_fkey] FOREIGN KEY ([event_id]) REFERENCES [dbo].[Event]([event_id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Ticket] ADD CONSTRAINT [Ticket_user_id_fkey] FOREIGN KEY ([user_id]) REFERENCES [dbo].[User]([user_id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[EventAttendee] ADD CONSTRAINT [EventAttendee_event_id_fkey] FOREIGN KEY ([event_id]) REFERENCES [dbo].[Event]([event_id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[EventAttendee] ADD CONSTRAINT [EventAttendee_user_id_fkey] FOREIGN KEY ([user_id]) REFERENCES [dbo].[User]([user_id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[EventAttendee] ADD CONSTRAINT [EventAttendee_ticket_id_fkey] FOREIGN KEY ([ticket_id]) REFERENCES [dbo].[Ticket]([ticket_id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Notification] ADD CONSTRAINT [Notification_recipient_id_fkey] FOREIGN KEY ([recipient_id]) REFERENCES [dbo].[User]([user_id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Notification] ADD CONSTRAINT [Notification_event_id_fkey] FOREIGN KEY ([event_id]) REFERENCES [dbo].[Event]([event_id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[EventStatistic] ADD CONSTRAINT [EventStatistic_event_id_fkey] FOREIGN KEY ([event_id]) REFERENCES [dbo].[Event]([event_id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[UserProfile] ADD CONSTRAINT [UserProfile_user_id_fkey] FOREIGN KEY ([user_id]) REFERENCES [dbo].[User]([user_id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[BookingHistory] ADD CONSTRAINT [BookingHistory_user_id_fkey] FOREIGN KEY ([user_id]) REFERENCES [dbo].[User]([user_id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[BookingHistory] ADD CONSTRAINT [BookingHistory_event_id_fkey] FOREIGN KEY ([event_id]) REFERENCES [dbo].[Event]([event_id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[BookingHistory] ADD CONSTRAINT [BookingHistory_ticket_id_fkey] FOREIGN KEY ([ticket_id]) REFERENCES [dbo].[Ticket]([ticket_id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Permission] ADD CONSTRAINT [Permission_role_id_fkey] FOREIGN KEY ([role_id]) REFERENCES [dbo].[UserRole]([role_id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[EventApproval] ADD CONSTRAINT [EventApproval_event_id_fkey] FOREIGN KEY ([event_id]) REFERENCES [dbo].[Event]([event_id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[EventApproval] ADD CONSTRAINT [EventApproval_approved_by_fkey] FOREIGN KEY ([approved_by]) REFERENCES [dbo].[User]([user_id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Report] ADD CONSTRAINT [Report_generated_by_fkey] FOREIGN KEY ([generated_by]) REFERENCES [dbo].[User]([user_id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[PasswordResetToken] ADD CONSTRAINT [PasswordResetToken_user_id_fkey] FOREIGN KEY ([user_id]) REFERENCES [dbo].[User]([user_id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[ManagerRequest] ADD CONSTRAINT [ManagerRequest_user_id_fkey] FOREIGN KEY ([user_id]) REFERENCES [dbo].[User]([user_id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[ChatRoom] ADD CONSTRAINT [ChatRoom_event_id_fkey] FOREIGN KEY ([event_id]) REFERENCES [dbo].[Event]([event_id]) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Message] ADD CONSTRAINT [Message_chat_room_id_fkey] FOREIGN KEY ([chat_room_id]) REFERENCES [dbo].[ChatRoom]([chat_room_id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Message] ADD CONSTRAINT [Message_sender_id_fkey] FOREIGN KEY ([sender_id]) REFERENCES [dbo].[User]([user_id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Participant] ADD CONSTRAINT [Participant_chat_room_id_fkey] FOREIGN KEY ([chat_room_id]) REFERENCES [dbo].[ChatRoom]([chat_room_id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Participant] ADD CONSTRAINT [Participant_user_id_fkey] FOREIGN KEY ([user_id]) REFERENCES [dbo].[User]([user_id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
