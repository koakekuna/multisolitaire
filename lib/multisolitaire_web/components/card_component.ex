defmodule MultisolitaireWeb.CardComponent do
  use Phoenix.Component

  @doc """
  Renders a playing card.

  ## Examples

      <.card rank="ace" suit="hearts" flipped={false} />
      <.card rank="10" suit="spades" flipped={true} />
  """

  # Define the attributes the card component can accept
  attr :rank, :string, required: true
  attr :suit, :string, required: true
  attr :class, :string, default: nil
  # Option for different back designs
  attr :back_variant, :string, default: "blue"
  # Whether the card is showing its back
  attr :flipped, :boolean, default: false

  def card(assigns) do
    ~H"""
    <div
      class={[
        "card-container",
        @class
      ]}
      data-rank={@rank}
      data-suit={@suit}
    >
      <div class={["card", if(@flipped, do: "flipped")]}>
        <!-- Front of the card -->
        <div class="card-front">
          <img src={"/images/cards/#{card_filename(@rank, @suit)}"} alt={"Card #{@rank} of #{@suit}"} />
        </div>
        <!-- Back of the card -->
        <div class="card-back">
          <img src={"/images/cards/#{@back_variant}.svg"} alt="Back of card" />
        </div>
      </div>
    </div>
    """
  end

  # Helper function to get the file name for the front of the card
  defp card_filename(rank, suit) do
    "#{suit}_#{rank}.svg"
    |> String.downcase()
  end
end
