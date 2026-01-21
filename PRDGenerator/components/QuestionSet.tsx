interface Question {
  id: string;
  text: string;
  options?: Array<{ label: string; value: string }>;
  isOpen?: boolean;
  placeholder?: string;
}

interface QuestionSetProps {
  question: Question;
  value?: string | string[];
  onChange: (value: string | string[]) => void;
}

export function QuestionSet({ question, value, onChange }: QuestionSetProps) {
  if (question.isOpen) {
    return (
      <div className="space-y-3">
        <label className="block text-lg font-semibold text-white">
          {question.text}
        </label>
        <textarea
          value={(value as string) || ""}
          onChange={(e) => onChange(e.target.value)}
          placeholder={question.placeholder}
          className="w-full h-24 bg-slate-700 border border-slate-600 rounded-lg p-4 text-white placeholder-slate-400 focus:outline-none focus:border-blue-500 focus:ring-1 focus:ring-blue-500"
        />
      </div>
    );
  }

  return (
    <div className="space-y-3">
      <label className="block text-lg font-semibold text-white">
        {question.text}
      </label>
      <div className="space-y-2">
        {question.options?.map((option) => (
          <label key={option.value} className="flex items-center gap-3 cursor-pointer group">
            <input
              type="radio"
              name={question.id}
              value={option.value}
              checked={value === option.value}
              onChange={(e) => onChange(e.target.value)}
              className="w-4 h-4 text-blue-600 cursor-pointer"
            />
            <span className="text-slate-300 group-hover:text-white transition">
              {option.label}
            </span>
          </label>
        ))}
      </div>
    </div>
  );
}
