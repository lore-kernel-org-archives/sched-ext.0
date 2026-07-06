Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7663BFAD1
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381240; cv=none; b=NK7S8TDegRyGSbPcKQm4y03eQv6SdzJyCXEEwb5+XpeMc/ZxMeiPxMcE2QH4lpv6HAshTNas+J2dy5NF+XYagS38LZaiEA0ympUU1NFSIMQeQRzoIcKehnjzweUkfSsPofEI23FJKNNwffUtsfBJdyJ+fa+SBBlxAHqgqyU6CCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381240; c=relaxed/simple;
	bh=vTaejcaMN4fvpqBrllTExP+Jh3a/xng+QWqjBtpAxDE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Wl7pEJ1wQFGFMn2i9f6gvI/tERqvYKso3Y8oQe4RRMFiFpXblF//c7kIM16hkvlR7v5KvhK3mvzNsq5dIczsXT/Reahp/LTRsj/ffwVWa5Kq00dqgdBynXBWjUMkUzLUbPjPlZyFRcI7w+SPrJ3gkuOiW9Llcn3qIVzHS3sI/As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOrbm9Wj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOrbm9Wj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B691F00A3A;
	Mon,  6 Jul 2026 23:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381239;
	bh=vTaejcaMN4fvpqBrllTExP+Jh3a/xng+QWqjBtpAxDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dOrbm9WjVz/urKuHQndeoHLqrYsky496hbgpFXIE0cUeWPvbdKJ5+bcvq6VK5VlRN
	 4Rvg94pdRjI0TderoUJBcWtCdvqTkWAuKy4C2W4pvNRjFjIbwv8uua8Gj93tCMTN/j
	 LNZ7pHL3c+lyfY0aeU7Y/IIab7xfaNwkhn2rMmTZrMZHhBrDekIzEfhNGDrCYSCRAn
	 evz3xvbc+q1XQKgG0lWfdK4q1GXix69YenT9pTzU3eNz1zHToUvRUNR9bq0JAighNe
	 Z5tkKw4pydvEGI6Z5/qaYih1J7p0puonFIc9MlIOCGSusJIMg+JAYVVvrK/Xfg3np5
	 J9wMyj9YSdRJg==
Date: Mon, 06 Jul 2026 13:40:38 -1000
Message-ID: <ad4a4c46c02a5e8e9c427a8f461988fc@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH v2 sched_ext/for-7.3 11/36] sched_ext: Add CID sharding
In-Reply-To: <20260706015326.C61741F000E9@smtp.kernel.org>
References: <20260706014058.439853-1-tj@kernel.org> <20260706014058.439853-12-tj@kernel.org> <20260706015326.C61741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Mon, 06 Jul 2026 01:53:26 +0000, sashiko-bot wrote:
> - [Medium] When primary threads are offline, `calc_shard_layout` undercounts the number of unique cores in the LLC, leading to excessive shard fragmentation.

False positive. Offline cpus are scrubbed from their siblings'
topology_sibling_cpumask (x86 remove_siblinginfo, generic
remove_cpu_topology), and scx_cid_init() runs under cpus_read_lock, so the
primary-thread test sees a consistent online-only mask. Same idiom as
topology_is_primary_thread().
