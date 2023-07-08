defmodule PhoenixTherapist.NotesTest do
  use PhoenixTherapist.DataCase

  alias PhoenixTherapist.Notes

  describe "notes" do
    alias PhoenixTherapist.Notes.Note

    import PhoenixTherapist.NotesFixtures

    @invalid_attrs %{description: nil}

    test "list_notes/0 returns all notes" do
      note = note_fixture()
      assert Notes.list_notes() == [note]
    end

    test "get_note!/1 returns the note with given id" do
      note = note_fixture()
      assert Notes.get_note!(note.id) == note
    end

    test "create_note/1 with valid data creates a note" do
      valid_attrs = %{description: "some description"}

      assert {:ok, %Note{} = note} = Notes.create_note(valid_attrs)
      assert note.description == "some description"
    end

    test "create_note/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Notes.create_note(@invalid_attrs)
    end

    test "update_note/2 with valid data updates the note" do
      note = note_fixture()
      update_attrs = %{description: "some updated description"}

      assert {:ok, %Note{} = note} = Notes.update_note(note, update_attrs)
      assert note.description == "some updated description"
    end

    test "update_note/2 with invalid data returns error changeset" do
      note = note_fixture()
      assert {:error, %Ecto.Changeset{}} = Notes.update_note(note, @invalid_attrs)
      assert note == Notes.get_note!(note.id)
    end

    test "delete_note/1 deletes the note" do
      note = note_fixture()
      assert {:ok, %Note{}} = Notes.delete_note(note)
      assert_raise Ecto.NoResultsError, fn -> Notes.get_note!(note.id) end
    end

    test "change_note/1 returns a note changeset" do
      note = note_fixture()
      assert %Ecto.Changeset{} = Notes.change_note(note)
    end
  end
end
