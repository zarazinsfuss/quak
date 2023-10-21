
# Quak - Quick Notes for Quartz and other digital garden frameworks

Quak is a handy command-line tool designed to streamline your note-taking and management process for Quartz, a fast and feature-rich static-site generator. With Quak, you can quickly create, edit, configure, and organize your Quartz-based notes, making it easier to maintain your personal digital garden, wikis, and websites.

## Installation

### Prerequisites

Before you begin, ensure you have the following prerequisites:

- [Quartz](https://github.com/jzhaoxyz/quartz): Make sure you have Quartz installed, as it's the foundation for your static-site generation.

### Installation Steps

1. Clone the Quak repository to your local machine:

   ```bash
   git clone https://github.com/yourusername/quak.git
   ```

2. Navigate to the Quak directory:

   ```bash
   cd quak
   ```

3. Make the `quak` script executable:

   ```bash
   chmod +x quak
   ```

4. Optionally, you can move the `quak` script to a directory in your system's `$PATH` for easier access:

   ```bash
   sudo mv quak /usr/local/bin/
   ```

Now, you can use the `quak` command from any directory to manage your Quartz notes.

## Configuration

Quak supports configuration through a `.config/quak/config` file. You can define the following configuration options in this file:

- `ROOT_DIR`: The root directory of your Quartz notes.
- `EDITOR`: Your preferred text editor (default is Vim).

Here's an example configuration:

```plaintext
ROOT_DIR=/path/to/your/quartz/notes
EDITOR=nano
```

To create or edit the configuration file, use the following commands:

```bash
mkdir -p ~/.config/quak
touch ~/.config/quak/config
```

Edit the `config` file with your preferred text editor and save your configuration.

## Usage

### Basic Usage

- To create a new Quartz-based note, simply run:

  ```bash
  quak Note_Title
  ```

  Follow the prompts to select or create a topic, and the note will open in your configured text editor.

- To display a tree-like listing of all your notes, use:

  ```bash
  quak --tree
  ```

- To synchronize your Quartz notes (e.g., `ngx quartz sync`), use:

  ```bash
  quak --sync
  ```

- To edit your configuration, use:

  ```bash
  quak --config
  ```

### Advanced Usage

- You can also use Quak to edit your notes by specifying the note title:

  ```bash
  quak --edit Note_Title
  ```

This will open the specified note in your configured text editor.

## Example

Here's an example workflow using Quak:

1. Create a new Quartz note:

   ```bash
   quak My_New_Note
   ```

2. Select or create a topic when prompted.

3. Edit your note in your configured text editor.

4. To view all your notes in a tree-like structure:

   ```bash
   quak --tree
   ```

5. To synchronize your Quartz notes:

   ```bash
   quak --sync
   ```

6. To edit the note you created earlier:

   ```bash
   quak --edit My_New_Note
   ```

Enjoy the convenience of managing your Quartz-based notes with Quak!

## About Quartz

[Quartz](https://quartz.jzhao.xyz/) is a fast, batteries-included static-site generator that transforms Markdown content into fully functional websites. Thousands of students, developers, and teachers are already using Quartz to publish personal notes, wikis, and digital gardens to the web.

Quak simplifies the process of creating, editing, and configuring Quartz notes, making it easier for you to manage your digital content.

## Contributing

Feel free to contribute to Quak by creating issues or submitting pull requests on [GitHub](https://github.com/yourusername/quak).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
