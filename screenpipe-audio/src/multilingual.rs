use candle::{Result, Tensor};
use tokenizers::Tokenizer;
use crate::whisper::{token_id, Model};

pub fn detect_language(
    _model: &mut Model,
    tokenizer: &Tokenizer,
    _mel: &Tensor,
) -> Result<u32> {
    // Always return the token ID for English
    let english_token = token_id(tokenizer, "<|en|>")?;
    Ok(english_token)
}
