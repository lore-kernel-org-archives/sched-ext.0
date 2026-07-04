Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0231C84AB
	for <sched-ext@lists.linux.dev>; Sat,  4 Jul 2026 00:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783126479; cv=none; b=QZrBiXNJeHfQbHNRwg6up65fCL0IQjh4FuK2SLb3KS3UGewRzRkCctHuP2zPhITWVrBTtnI182fhrSJ8Ll0TaeIB8GmYsd6xoTbczEIvpvQjaBXVUQumnxD1Zfv/GZH243OghVU9+J3kmPTXFv8vB3H2iSiHYQHYXmY7UQ+6mvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783126479; c=relaxed/simple;
	bh=t7uT5WcuEkrtYL1Q9UVhHp5RwSjCEMMsM9Q6AfQ356Y=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=BsXw//WXntqv5/731mV9WPz/wjd+/DKaSC01TbHmc89QSJXr5kyI8H1+egNKRXN6DMkVNUVBci686nQuq5IKkw8Ml68O5NeNPSyZDo9PkjQnIFU1BBcdTW29+tbQ311ZcQdqsSVJNZvhp6BY+nhbG/Li0FNz2te8dHiEzGgFCes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfRKQ0bz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfRKQ0bz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AC01F00A3A;
	Sat,  4 Jul 2026 00:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783126478;
	bh=t7uT5WcuEkrtYL1Q9UVhHp5RwSjCEMMsM9Q6AfQ356Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hfRKQ0bzlGXj2L1yqfbvci7cZeDNVZNnLJ5wqSP7Y5Ek5WKseENoI0JRb47qS2URi
	 kb481ZyxXblP/Eq88s9pNwEv4bdKerDGwb7K+7drrGuLGOohAjL52DwGRJ4zPsmoQI
	 hdVTISU2zPPVyIVJlvaWGHoIPAKtNuGXKZ6LGiZ9/3vg15FJmzqvSItJ4k8Ok2LAid
	 pVa2Xg9v3kc7jaZXVw4ObM52YhpfDXrbtRd5JZxvPDzOOJrRCSkZi6JVg/e7seTkUt
	 6yMNSpGoafCjxI3nhg1lqk5aMYXde5+NUoiLsFseLg+32Fjl8+0npK7hllUflPOvW4
	 kCYH/D5zFEjWg==
Date: Fri, 03 Jul 2026 14:54:36 -1000
Message-ID: <5d96cbf60ce0e68269050075611f3ffc@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.3 30/32] sched_ext: Add scx_bpf_sub_kill() to evict a child sub-scheduler
In-Reply-To: <20260703144502.3B0281F000E9@smtp.kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org> <20260703080159.2314350-31-tj@kernel.org> <20260703144502.3B0281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> [High] Out-of-bounds read due to missing `__str` suffix on the `fmt`
> argument in `scx_bpf_sub_kill_bstr`.

This matches the existing bstr kfuncs (scx_bpf_exit_bstr(),
scx_bpf_error_bstr(), scx_bpf_dump_bstr()). It's worth doing, but as a
change across the whole family - I'll follow up on it separately rather
than fold it into this series.

Thanks.
