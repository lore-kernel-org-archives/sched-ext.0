Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCC12236E0;
	Mon,  6 Jul 2026 23:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381241; cv=none; b=HhBeKtUeK7mWtvkWtsvF/OWT/F1GkT53h9FmluirpkNpAqLj7QpKULefr5wikRfaZLNAmZplppHvVXPI7aaFVccAwLiVv/5AtNIanqvABQBYYdxsTk0VqzG7cPAHlcUcF1w4I00J2CI7hXeiS0tBZ0zfg1THquQWHpEyr7lkRLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381241; c=relaxed/simple;
	bh=Hqs9IbjhGoVcqwAj9n8CtOrI3cwfwcSb7L9cPweypE4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=LNdDPUpcE1vg94uanjFE9SXAT5S3qSGqoU4SgPr1JaBU/rM72jod+XaP8KA4KycZfUDWJ9mYZLT1qT2w7QQnuCYD9nOuoXIYczP1lXeQc9nsraPngVQOMwoBN6AKMFv7J/RYxwf10b/umBkW3Dm+VrJaVlLaMg7o9N2N/FghZY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuHxcX/o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuHxcX/o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97AF1F000E9;
	Mon,  6 Jul 2026 23:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381240;
	bh=Hqs9IbjhGoVcqwAj9n8CtOrI3cwfwcSb7L9cPweypE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HuHxcX/oOEIGWDtyn1+89nLYak+OzmgOfKxSU8OK6Kde39dnFSn40H/gYfCio9nUG
	 t5PFBkzDhctcZAxalJvfrap9DBeaRutNOQ+M21+y/HKewoJqOohulaK2luiFQ3nlD/
	 xH9K79mVwwl1glb64pRj/80WdZjSU8vT0OxvhaXpOJ6lQYs8pqN82HlI40jVQkOVL6
	 /JK1KiPZI0n4j2vZ4P92SY4X4qHY6mLsA2NRinevh9x5UYWhWy/g804LzS3BZu0tTd
	 oBIv5LALa5dyV/zilb9q7lH6IOO7lm9gm9iHJd4oJnRpfUga+YAKXPWyYz63pD9seQ
	 1UFxJODsFRkXw==
Date: Mon, 06 Jul 2026 13:40:39 -1000
Message-ID: <205302f24c49036fea6afab94ea11ba5@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.3 15/36] sched_ext: Add scx_cmask_ref for validated arena cmask access
In-Reply-To: <aktvuGHVDEKnLlu5@gpd4>
References: <20260706014058.439853-1-tj@kernel.org> <20260706014058.439853-16-tj@kernel.org> <aktvuGHVDEKnLlu5@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hi Andrea,

On Mon, 6 Jul 2026 11:04:56 +0200, Andrea Righi wrote:
> We validate the requested CID range, but not whether the cmask declares enough
> bits[] capacity for that range, unless I'm missing something. For example,
> nr_cids can require multiple words while alloc_words is one. Does the ref also
> need to account for the storage capacity described by alloc_words?

Right, that's a real gap - thanks. For v3, _init() also snapshots
alloc_words and rejects when SCX_CMASK_NR_WORDS(nr_cids) > alloc_words, so a
range that doesn't fit its declared storage is refused before any bits[]
access. I folded this into the patch together with dropping __counted_by,
which read the same BPF-writable count.

Thanks.
