void save_history() {
    char path[512];

    snprintf(path, sizeof(path), "%s/.hist_list", getenv("HOME"));

    FILE *fp = fopen(path, "w");
    if (fp == NULL) {
        perror("Failed to open history file for writing");
        return;
    }

    for (int i = 0; i < history_count; i++) {
        fprintf(fp, "%d %s\n",
                history[i].cmd_number,
                history[i].command);
    }

    fclose(fp);
}