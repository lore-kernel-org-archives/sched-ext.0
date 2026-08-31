Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19CD392807;
	Mon, 31 Aug 2026 22:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788215792; cv=none; b=lTjcb9xAr59AnizV1bcG3un7BYUnvxp9ifKFyDsituIOisJfTIXa1GEMzzd4VaH4JlkTIS7kbby0HWo1D9y0hTDtnvV8orWOLsW76ovEAyItSpv5EN7/X64FoIVw5KwXxqm3QtNMnze1xm+JRko75kESrzEDbADbAsXh21J+Y50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788215792; c=relaxed/simple;
	bh=dHMzgd94yt0GZNrfBJQ6cs++VCcr0oxFyF5G7Q+0jn8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=QwE/MTEK0Qr9YcxblOBjVihnezZNEoWeVCBsr61AVal5fE7mC0BSnARNJT6wmhyUMS/ZUOm6I4JSQVwahEfqKWiOR+RcdpZvZ6mDu/57IJ/3iqRhjQemLLAo4H8re/y+jLcyRfyLd5176FaTdv0KyDg/6w9ruuY8ByuTh3A26ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1uq4FLD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1uq4FLD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640421F000E9;
	Mon, 31 Aug 2026 22:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788215790;
	bh=dHMzgd94yt0GZNrfBJQ6cs++VCcr0oxFyF5G7Q+0jn8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Y1uq4FLD0vNbLHbZ1XUDRN7/cBtk9SV34G8vcW5BzN4VLn17OYA+YtjA7pkbdPvLD
	 MbpTK3OXtaVjE336Nl5uEcK1AGJyjAGa9MC/wD2uHGMs0Q1hOOmQdw1jYX6hzDE0Bo
	 2hQHMi7mg6HsidRHKJ6Ep1MJg6jLUN2jSqf/YBjvuX6CDlmQ1Xz8k2ATrwCYW9cEPr
	 Bu+73eKMYWVs9YAjM2gppq6/lTYaFpGeJ7XZxee9Uv9pS/aCvtaSEXNiUO156GakT1
	 jMT5+/eK3Rmv41rpLgc/Ftsm6c7Di4ERoY/xbRp7hYRdI+braxm0rIJQdyDdwAQ2aN
	 6xb+Tx0PGdeRw==
Date: Mon, 31 Aug 2026 12:36:29 -1000
Message-ID: <e9cd7bd7c303b57d8716c4a8cab35058@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Michal Blaszczyk <michalblk@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Kuba Piecuch <jpiecuch@google.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched: Lift cgroup update locking to core to prevent CFS/SCX divergence
In-Reply-To: <20260824074913.2468177-1-michalblk@google.com>
References: <20260824074913.2468177-1-michalblk@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Mon, Aug 24, 2026 at 07:49:13AM +0000, Michal Blaszczyk wrote:
> Concurrent writes to cgroup control files (such as cpu.shares or
> cpu.weight) can lead to state divergence between CFS and SCX.
>
> For instance, in cpu_shares_write_u64(), the CFS update is serialized
> by shares_mutex (internal to fair.c), but this lock is dropped before
> scx_group_set_weight() is called. The latter only acquires a read
> semaphore (scx_cgroup_ops_rwsem), allowing multiple threads to evaluate
> and act on the sched_ext update concurrently.
...
> Fixes: 819513666966 ("sched_ext: Add cgroup support")
> Signed-off-by: Michal Blaszczyk <michalblk@google.com>

Acked-by: Tejun Heo <tj@kernel.org>

Peter, would you mind picking this up?

Thanks.

--
tejun
