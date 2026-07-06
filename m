Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4411F2236E0
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 23:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381255; cv=none; b=XjmyN935p/WoU0juZqfFsdCRMOpqCZ45yOU7W7cW7I3zwloupEKmqqQk+0p8ECF8nTGTxGiqW8X8Jm09jGkV04gJ6Om2tTEzxQoqnhUsf4F8bA0qIWvUvY3NJrfPa1XS/m1winwDB/UTO3Dma2kLgUvtLaQ5Mh7Xk2143KpD0tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381255; c=relaxed/simple;
	bh=Jr0UWeLgiybKBKNtUEBMpi6JF104KjTqX8Ktg201rWA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=CZ+tnBTItrTMS+tCvqj5I0tm1ydLOpb0aUEif1ChlHMnXfsXs8mwAP61jCTrH6TCajPX0PTtyO1eVa+rk6rhebYztEDWgBFErUBj1OLIVDxKNei8JFOMepkwxVoAgC8GRC8O4BbxhmTSmgY5u2/LLg1b3Nytd3Ie8ntERnu4JlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TY02z4Ti; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TY02z4Ti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF2E1F000E9;
	Mon,  6 Jul 2026 23:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381254;
	bh=Jr0UWeLgiybKBKNtUEBMpi6JF104KjTqX8Ktg201rWA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TY02z4TiGZCC+pRLa2pYU50hJ6CoTP7LNxe3TxgF4ziUr29tNxvlzX55tB3gzSeJA
	 SdXFyw+lllvsD6jWOmTtztJ13IKCDF6TabGxD4pfpX+sXVO6jUQcb3rl1gnatEjnj1
	 tGDDXvBmSobKzvEfhPCDlOhFSWMJD/eALhO4m5/tyZWIelQc7OMxdNbPcnY6wmu8mt
	 XNWdgEzLP8zeTjkIUSmwbdPDO+j9W9smHzwlFZ7hbTXKjOQqPVr9imoaDZd1qR1OeF
	 xjwbIFsPlFU7r8A/zVNU2TbnThS2RBDItqqn3hEr6HJEjYMGXc3sjXL4gnaO2sY2yO
	 NBCZgEkMHBaVw==
Date: Mon, 06 Jul 2026 13:40:53 -1000
Message-ID: <0224d1c84c054892812756c3ae76dc02@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH v2 sched_ext/for-7.3 34/36] sched_ext: Add scx_bpf_sub_kill() to evict a child sub-scheduler
In-Reply-To: <20260706021238.8FC461F000E9@smtp.kernel.org>
References: <20260706014058.439853-1-tj@kernel.org> <20260706014058.439853-35-tj@kernel.org> <20260706021238.8FC461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Mon, 06 Jul 2026 02:12:37 +0000, sashiko-bot wrote:
> - [High] Missing `__str` suffix on the `fmt` parameter in `scx_bpf_sub_kill_bstr` (and existing `_bstr` kfuncs) allows BPF programs to bypass string validation, leading to out-of-bounds reads and kernel panic in `bpf_bprintf_prepare()`.

False positive for this series. scx_bpf_sub_kill_bstr() matches the
established _bstr kfunc convention byte-for-byte and is a privileged
struct_ops interface. Adding __str to the whole _bstr family would be a
separate tree-wide change, not this patch.
