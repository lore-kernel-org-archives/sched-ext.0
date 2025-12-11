Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CBB21CC79;
	Thu, 11 Dec 2025 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765470817; cv=none; b=FfXZ+AqROiZRDVXJMbaA2qCnb7pXWQ/PXJjSaZEM/8gF/FK1B7MeKHug4zu4+E5K9vwj5nUugTH+IhOcuf6zsa4EK+hVcbAqA94I5zh1gzLygvClpSDCBvZE74eemAoJDjsODojdoehpek2iuG8rBZx25NPdAJwUmhD9joPQugI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765470817; c=relaxed/simple;
	bh=lbrIanfzA3sXmf/XxrBzZeKGib+/+MV0kLuSpoUi28U=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=KgRb9B9AihgQJoYVJRkWhOJU+qXnF0UuEoyY56PY8TNUC101rBIKKPLPgHan2TMUBqhSyHUcHMU148ZS+OHvXJ4sKRHknScPzWjrOX2CetzioQn7iXjnmjL1Wekd7IbzUwpzZjSjUCdDVkP5eRswlxZOvbDF+2ANUfUHkHQt/Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UD3IwBCt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UD3IwBCt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA59DC4CEFB;
	Thu, 11 Dec 2025 16:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765470817;
	bh=lbrIanfzA3sXmf/XxrBzZeKGib+/+MV0kLuSpoUi28U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UD3IwBCtwMTicUu32xK3HgJNVie0YmVqMS5dTOfWbpdEnwWZxoZzo9OH2ftUZeCYK
	 HFa7/4JyOmHkxMCkYSlZWwg16UZNfKUddigvCOJDzJhf6dqhOdE9Af7aZZiCWUcBmO
	 rZN0b4wKKYmSk3UHwYJ52kqKToF6BceoHRyCXSLQijAiescAFxS+aM1aZzfx9P3KGv
	 Sm6bUKMcr8I5D1w6sCvKgv2R+LH1r7wWL8Rr2z8yjstMudb9hi4ClrbbvLXXBT8KEP
	 n61dXYdsbbb188vP190W88yL+RhwOC4ZXi7ZKPREIDFsnNSQJC5QCf7lA5g4DK0oQU
	 QRd65cl/GSmMg==
Date: Thu, 11 Dec 2025 06:33:35 -1000
Message-ID: <d454426e0970ba58bdf40007d52daae0@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Chris Mason <clm@meta.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.19-fixes] sched_ext: Fix bypass depth
 leak on scx_enable() failure
In-Reply-To: <286e6f7787a81239e1ce2989b52391ce@kernel.org>
References: <286e6f7787a81239e1ce2989b52391ce@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-6.19-fixes.

Thanks.
--
tejun
