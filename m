Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197CC325709;
	Wed, 18 Feb 2026 17:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771434377; cv=none; b=qdz2isyC5PAXCSmOEQWTxrlOBReI5ZlaChih+n3qivKkeyhX6DCigjWDGLi3CG/n0ch0w7ZqyBgvBmYD9n6+Nu0wyXEiVazn2lzjNM8hrzOYsItai3uzvOBziJWe7CtBjaNsqbvOac2zYbt7ts8+KTFVfqr682jgkBemn466rP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771434377; c=relaxed/simple;
	bh=5/Jg/cpVR7WaUS8y+4lvIsX6pu4+Qt9Jv+1IUK5YwJ4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=K6BZSIzz3aNUWNzTdmEWfjgVXhygjMB5nDBTaWvsFVG0R7e1OOzuuKKvWQbU9inP3ED/te4Q0n/qi/7YiybStQifW5jYmo4gZ8600WVWf06AkIiJpIUzHCDmfMuNXtuYQ9iO6XJYpkSyGPwrQUlx31aTgo9+T/gw+gvwUJ8a19k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9J2ZvkR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9J2ZvkR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFEEC116D0;
	Wed, 18 Feb 2026 17:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771434376;
	bh=5/Jg/cpVR7WaUS8y+4lvIsX6pu4+Qt9Jv+1IUK5YwJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l9J2ZvkRwnCkqnymUjBCsQJyhTi/O+Ixii//2Kf79rXYNiTH4OfzgTFOXpIWcGx8U
	 PML0dicnqAcQgR32mrKmDrLCSgzrAhXf1fW2oFTTFi6osf7yUB6Csvsugf9reix8yk
	 iPQdPCnVrP1DDfDia24lZGLHTBk1wtRUg4l6bPBVfG65TWrUxV6L2KpORK51QbY+Nf
	 EXMn/PYrfzh59Qmg4KzMdd+75vnJiQkmdMCL05e4UMgvawjk7A6Qf4XgKFP/OP4f7r
	 klNpkRm8TtGLxgqcOm6t0NIczOMVpHbmsPQW56ILVtsJTcq0A3QCFMNUNmgOfQTCRd
	 kMYzxZnQzqpYw==
Date: Wed, 18 Feb 2026 07:06:15 -1000
Message-ID: <72c8c0f5a1e57b6f7ca53f16f1fbad0c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: David Vernet <void@manifault.com>,
 linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] tools/sched_ext: scx_central: fix CPU_SET and skeleton
 leak on early exit
In-Reply-To: <20260217194800.87403-1-devnexen@gmail.com>
References: <20260217194800.87403-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.0-fixes.

Thanks.
--
tejun
