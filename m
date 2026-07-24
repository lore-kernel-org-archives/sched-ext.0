Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C74355F49;
	Fri, 24 Jul 2026 22:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784931559; cv=none; b=oY7eWBkffCEBwgdDEewjZMOTOqt7/I8mhmdtX89dJ0vWT1IUNjO3mTByAqVai/ryXRZF20oZH85+6m3fsNCKR9rKu6A6X5XZht1Z7RUXrEKuUHEE/imYpW/X3ECom51bqfgRRmnwmBUZwXeLkQhYAI7is4j1ia/AzyPqMAIYpSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784931559; c=relaxed/simple;
	bh=fGDWWfowzpXIrI0ZvwndC2fTbmpXJOYl66aJ4IIpJY0=;
	h=Date:Message-ID:From:To:To:To:Cc:Cc:Cc:Subject:In-Reply-To:
	 References; b=qVEJrOlN/FRY0Sbqu04/C4P0wZb9ahcvQMUCfQkLJwJJbhC3yab4M824yPSeGu+XhDzHH6z8nTPdKzkxr4tepk2ZQYOYgeYSbeeYccgX3QikILBzPABymA3IVaQbQVVym+OO7+XRMCFCB5oJ0Iivsp929/IBYRYTx6OSJWi86+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SI8eXRtb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SI8eXRtb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7F51F000E9;
	Fri, 24 Jul 2026 22:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784931557;
	bh=txFBFtKcc7otgpO/bhOIQ+hDUM8/J0XHUHCiumy+fS0=;
	h=Date:From:To:To:To:Cc:Cc:Cc:Subject:In-Reply-To:References;
	b=SI8eXRtbFCYsWhWd3MMMwxCvQZcOsauHyaiQ+oUC70qFjU5vEsclsGLAWDnfG0gMU
	 3iuLLK0ryGgkrWGthD9BIcE01qNfov26tWwz7X1ZzufOm+x++6hiZIa5zSRxxRsfRX
	 +UZ9lX4LiT05+rPKk+HkWOJ892Wi8SG03na9eka6b8h4JbJ6fLqpqQQWH+Dto/JqKU
	 xM28/egYI8zgBDqCRko/SeKzIMqOjcssOpBuRfF9XBoDbgGvDOzDnbmTZMBYA+MkJy
	 jiA7y51+xe37hPxepvWI94XyXZEy667X2pEiqq/rA27ZIHG0BIoxnok3AS1O+qNYd9
	 LrUP5mYVO0+BQ==
Date: Fri, 24 Jul 2026 12:19:16 -1000
Message-ID: <cd382b8b4f83b647bbe1f1840d9880c9@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
To: Andrea Righi <arighi@nvidia.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev
Cc: Emil Tsalapatis <emil@etsalapatis.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v2 sched_ext/for-7.3] sched_ext: Follow-up fixes and missing cap enforcement
In-Reply-To: <20260724191651.1040227-1-tj@kernel.org>
References: <20260724191651.1040227-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Fri, Jul 24, 2026 at 09:16:46AM -1000, Tejun Heo wrote:
>  0001-tools-sched_ext-Don-t-restart-over-a-pending-exit-re.patch
>  0002-sched_ext-Gate-local-DSQ-reenq-on-baseline-cid-acces.patch
>  0003-sched_ext-Count-kicks-denied-for-lacking-baseline-ci.patch
>  0004-sched_ext-Factor-out-scx_cpuperf_set.patch
>  0005-sched_ext-Gate-scx_bpf_cidperf_set-behind-a-new-SCX_.patch

Applied 1-5 to sched_ext/for-7.3 with Andrea's Reviewed-by added.

Thanks.

--
tejun
