Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25042D8DD6;
	Thu, 12 Feb 2026 21:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770931184; cv=none; b=aRcVFucIOug105JodIh+rR27bFdOSZ5ng3ukVlhRLvpKH40S/k1nx4zE+BhRIhAUCXqcOerqU7GhwAIgL0AZm0Uu8C5G2ClTCW9ViiIAu8mg4RG4xzqQ6VPDRsmvJ9UQg1zfjK/eshTwV0Ha6Tg6l+Uqq3iZfFB/2Rxxx6E/72A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770931184; c=relaxed/simple;
	bh=q0HvZS/YpIeIkAf98Z4zsixq3nfpFMQecXt5beYI5No=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Yg7YX5VIqZl/ZcmKPwZMjUWxHTKdv3l9A4ZeOlBRxOpTyT5j2vl3JHJXk74NP9bqqnL5EnAY1/Es93tHSIU3Y9YBZahG6xzcJOHaYlj5g6YnRHtOqcTf2hHPRmfXfaO/OVlm4OanyUQVdsAEVBqVHZuxldAcbgDNIYZ16WoKmmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrqKzdJ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrqKzdJ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A563EC4CEF7;
	Thu, 12 Feb 2026 21:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770931183;
	bh=q0HvZS/YpIeIkAf98Z4zsixq3nfpFMQecXt5beYI5No=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LrqKzdJ4m5C1dIoEkyy6HoMrj8AUehuDeLLb+TUkF5+829P/d1NPqyjNl+yQAghL3
	 8YcrdzqOJ7Zkwp9rT8Sme3tcagD0nx5LaBHtiSulh/BD25cj0hg8PDX7jUpDoSw7Qv
	 gcBLKJ7oUUfFfdiiGIev46T3z9R/tW751giAiymxn4PXVsCsx8/z019smP+Z+NUcq3
	 42P8cMZhqPtMZqeOFRvUc5hAluKCvfy56X9ohF1E6u0OBJC7xK9MkL3c7jopNTePyj
	 FYKPJzthCokxQuQWAum3QvIjRefxQD/B2LTKzA818FbeZsF91yA2KtOb4w2giZnpJV
	 NsYtM4kBi8ASQ==
Date: Thu, 12 Feb 2026 11:19:42 -1000
Message-ID: <faf7f77374d5835270f754492e394dbe@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: Andrea Righi <arighi@nvidia.com>,
 linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH 3/3] scx_userland: fix restart and stats thread lifecycle
 bugs
In-Reply-To: <20260212203519.15091-1-devnexen@gmail.com>
References: <20260212203519.15091-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.0-fixes with the subject prefix updated to
"tools/sched_ext: scx_userland:".

Thanks.

--
tejun
