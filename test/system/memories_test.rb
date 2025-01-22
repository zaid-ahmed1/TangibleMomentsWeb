require "application_system_test_case"

class MemoriesTest < ApplicationSystemTestCase
  setup do
    @memory = memories(:one)
  end

  test "visiting the index" do
    visit memories_url
    assert_selector "h1", text: "Memories"
  end

  test "should create memory" do
    visit memories_url
    click_on "New memory"

    fill_in "Title", with: @memory.title
    click_on "Create Memory"

    assert_text "Memory was successfully created"
    click_on "Back"
  end

  test "should update Memory" do
    visit memory_url(@memory)
    click_on "Edit this memory", match: :first

    fill_in "Title", with: @memory.title
    click_on "Update Memory"

    assert_text "Memory was successfully updated"
    click_on "Back"
  end

  test "should destroy Memory" do
    visit memory_url(@memory)
    click_on "Destroy this memory", match: :first

    assert_text "Memory was successfully destroyed"
  end
end
