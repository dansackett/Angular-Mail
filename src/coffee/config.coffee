# Base Configuration For Application

# Email Messages
messages = [
    {
        from: 'Dan Sackett'
        subject: 'Hello, this is an email!'
        message: 'This is the message'
        date: 'August 15, 2014'
        is_in_inbox: true
        is_read: true
        is_sent: false
        is_draft: false
        is_selected: true
        is_spam: false
        is_archived: false
        is_deleted: false
        is_starred: true
    }
    {
        from: 'Tony Hawk'
        subject: 'Did you see that sweet jump I did?'
        message: 'It was the best jump in the world'
        date: 'August 4, 2014'
        is_in_inbox: true
        is_read: false
        is_sent: false
        is_draft: false
        is_selected: false
        is_spam: false
        is_archived: false
        is_deleted: false
        is_starred: false
    }
    {
        from: 'Bill Simmons'
        subject: 'New Mailbag column is finally up'
        message: 'Just finished the new mailbag column. Go and check it out!'
        date: 'August 1, 2014'
        is_in_inbox: true
        is_read: false
        is_sent: false
        is_draft: false
        is_selected: false
        is_spam: false
        is_archived: false
        is_deleted: false
        is_starred: false
    }
    {
        from: 'Dikembe Mutumbo'
        subject: 'No No No'
        message: 'You\'ll never dunk on me!'
        date: 'July 20, 2014'
        is_in_inbox: true
        is_read: false
        is_sent: false
        is_draft: false
        is_selected: false
        is_spam: false
        is_archived: false
        is_deleted: false
        is_starred: false
    }
    {
        from: 'Jimmy Buffet'
        subject: 'Come on down to margaritaville'
        message: 'We\'ll be waiting for you'
        date: 'July 13, 2014'
        is_in_inbox: false
        is_read: true
        is_sent: false
        is_draft: false
        is_selected: false
        is_spam: true
        is_archived: false
        is_deleted: false
        is_starred: false
    }
    {
        from: 'Father Time'
        subject: 'You\'re getting old'
        message: 'We\'re ready for you'
        date: 'July 13, 2014'
        is_in_inbox: false
        is_read: true
        is_sent: false
        is_draft: false
        is_selected: false
        is_spam: false
        is_archived: true
        is_deleted: false
        is_starred: false
    }
    {
        from: 'Junk'
        subject: 'Junk Mail'
        message: 'I\'m garbage'
        date: 'July 3, 2014'
        is_in_inbox: false
        is_read: false
        is_sent: false
        is_draft: false
        is_selected: false
        is_spam: false
        is_archived: true
        is_deleted: true
        is_starred: false
    }
    {
        from: 'Dan Sackett'
        subject: 'Great Scott!'
        message: 'You sent this message!'
        date: 'July 3, 2014'
        is_in_inbox: false
        is_read: true
        is_sent: true
        is_draft: true
        is_selected: false
        is_spam: false
        is_archived: false
        is_deleted: false
        is_starred: false
    }
]

# Filters
filters = [
    { name: 'inbox', text: 'Inbox'}
    { name: 'all', text: 'All Mail'}
    { name: 'sent', text: 'Sent'}
    { name: 'draft', text: 'Draft'}
    { name: 'starred', text: 'Starred'}
    { name: 'spam', text: 'Spam'}
    { name: 'archived', text: 'Archived'}
    { name: 'deleted', text: 'Deleted'}
]
