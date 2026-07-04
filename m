Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CFF2CCC5
	for <sched-ext@lists.linux.dev>; Sat,  4 Jul 2026 00:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783126471; cv=none; b=TVJwBQaf02L+VCM+H2Z2O8sIo+ttaHgk0lQG0iFKY8DPaPcUn8cNS4YcVGaaywg4MLvcSm7Fynsnh4lHwU3Fr3fM/YrhGRSEDX/hl2ASMw4BdRgNJgkF3rv+7OG3VkcVf0pZ7+oYkBcFcSaTmEfS36wtdhdDfdasiLeLpesVDEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783126471; c=relaxed/simple;
	bh=tEBBl7/8p+XTHtK5fO9+A0VC+SP1KQC5wlwGNg8akfE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=X2ePfqhFvsTu0r0Izk8MJ9yYyu3jeD3XMlE+GBXrm6MgtlDBCdhiodtzXGSr7ZNH5VmKlTmQ0el09qkz5NOYbZBWBy7vdoCCidTXs6ZMt+9MxWGqlvJgvDFN2VBfwt1YyCjKB8XSgplzobqBzg8foYZuEwHryvjb2iJoHZpuCqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdgQqW9Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdgQqW9Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E661F00A3A;
	Sat,  4 Jul 2026 00:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783126469;
	bh=tEBBl7/8p+XTHtK5fO9+A0VC+SP1KQC5wlwGNg8akfE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CdgQqW9YEZdFwWnF1PDg/wCakoFlqv1vAbjaXKCKD59R7aYQ8e4TFdnG0nP53aMO3
	 mQgEZn4bMRv+S/ShGPxjDO3UDKlZVw1KnZkhpG8y+P19jJ3wTppAZpPQFaB/PG1t6F
	 AsKoqaKxQw8wEGcYAFCzUObf+vntEv6JdQZWBexsjDk4pGDsE5dxX1KIsa1ae/o24l
	 A65VUECSys2vxG/S0CnWl73qw6vAGFjfkUO/DT/ZFTSk/64vFGdrY4avQngsNn3LGN
	 P8u4JlaULmKesRK/xghgXCQpHiHWGK2/E3iOxqeNO7h2m0TZp5PgKV9+udp+jMry0G
	 bqhmJKFq9wnlQ==
Date: Fri, 03 Jul 2026 14:54:29 -1000
Message-ID: <c4967d33479427bfbb6c07dc30d09244@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.3 18/32] sched_ext: Maintain per-cpu effective cap copies for single-read checks
In-Reply-To: <20260703120511.474CC1F000E9@smtp.kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org> <20260703080159.2314350-19-tj@kernel.org> <20260703120511.474CC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> [High] Unconditional array indexing with a potentially negative CID in
> `scx_process_sync_ecaps()` causes out-of-bounds reads for CPUs without
> a valid CID.

The index isn't reachable in practice - the free path uses
discard_queued_syncs() rather than scx_process_sync_ecaps(), and
balance_one() only runs with a valid cid - but v2 will move the
cid/shard computation below the guards.

Thanks.
