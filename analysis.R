library(tidyverse)
library(janitor)

# 1. Load and clean dataset
tickets <- read_csv("customer_support_tickets.csv", show_col_types = FALSE) %>%
  clean_names()

# 2. Summary tables
type_counts <- tickets %>%
  count(ticket_type, sort = TRUE, name = "ticket_count")

channel_summary <- tickets %>%
  group_by(ticket_channel) %>%
  summarise(
    total_tickets = n(),
    rated_tickets = sum(!is.na(customer_satisfaction_rating)),
    mean_csat = round(mean(customer_satisfaction_rating, na.rm = TRUE), 3),
    .groups = "drop"
  ) %>%
  arrange(desc(total_tickets))

priority_plot_df <- tickets %>%
  mutate(
    ticket_priority = factor(
      ticket_priority,
      levels = c("Low", "Medium", "High", "Critical")
    )
  ) %>%
  count(ticket_priority, name = "total_tickets")

top_products <- tickets %>%
  count(product_purchased, sort = TRUE, name = "ticket_count") %>%
  slice_head(n = 10)

# 3. Generate and save charts
p_channel <- ggplot(channel_summary, aes(x = reorder(ticket_channel, total_tickets), y = total_tickets)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(
    title = "Support Tickets by Channel",
    subtitle = "Total: 8,469 tickets across 4 channels",
    x = NULL,
    y = "Number of Tickets"
  ) +
  theme_minimal(base_size = 13)

ggsave("tickets_by_channel.png", plot = p_channel, width = 7, height = 4.5, dpi = 300)

p_priority <- ggplot(priority_plot_df, aes(x = ticket_priority, y = total_tickets)) +
  geom_col(fill = "darkorange") +
  labs(
    title = "Support Tickets by Priority Level",
    subtitle = "Ordered from Low to Critical (8,469 total tickets)",
    x = "Ticket Priority",
    y = "Number of Tickets"
  ) +
  theme_minimal(base_size = 13)

ggsave("tickets_by_priority.png", plot = p_priority, width = 7, height = 4.5, dpi = 300)

p_products <- ggplot(top_products, aes(x = reorder(product_purchased, ticket_count), y = ticket_count)) +
  geom_col(fill = "seagreen") +
  coord_flip() +
  labs(
    title = "Top 10 Products by Support Ticket Volume",
    subtitle = "From customer_support_tickets.csv (8,469 total tickets)",
    x = NULL,
    y = "Number of Tickets"
  ) +
  theme_minimal(base_size = 13)

ggsave("top_10_products.png", plot = p_products, width = 7.5, height = 5, dpi = 300)