Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A04D322A1F;
	Mon, 23 Feb 2026 20:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771877484; cv=none; b=sRE7uozRd24udd8AomODm8U1lnORLJGkr7MM6SOCfCHz/28w+S+cXmAkyPVPpSmmtRaE3oIzELf7EdSJXjPbskj/TGJKu5/EqlKf1nnj9lHGSq2R6I8MYqE+X49GZZJ4EPxK+gUPfqSS7ACdge1JgTTu/sLjCyTGYG2NUZXMX+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771877484; c=relaxed/simple;
	bh=ulE1k6eauZZH0/4+PfE51UXeZrdpf/P9FB1g1k1UsEY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=K/FGBCWkiVROyJPFs4SYJWbM3Sxh4E3ySHDMm4Kv4n1GWBo2VTCgHlX+HulHIuWwlLCap5DmnCqACBfWzUk1RYJt/WWz/+GBfcsLQ1rV+vhyUb5mmfiWO6kLlLAdqLUYhRkHB+P2Bv+DvS6e05d1/UBrcXorStWw1+TY3S5EvwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRFsX1GT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRFsX1GT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0CDC116C6;
	Mon, 23 Feb 2026 20:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771877483;
	bh=ulE1k6eauZZH0/4+PfE51UXeZrdpf/P9FB1g1k1UsEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZRFsX1GTFpcYK3nf5cO07uySJxVqZ6syfdbNFBUZhmAJA7hb866dgZvD37C9OG3ut
	 YqYA7TnoRS/805/HiDSjQf33Ad+jRCzznWo18ogH/Nwhf9eArsfXY1TWeDvRSM0pZl
	 1V6lgYrFxaYwniPFsmHIHrl1Fm7nhElN/2pPS0LgXiAuvh9VbIG9c52ekVI614gmCQ
	 TeO/yYl2xeB0DO2A8VGceKeP7S71FefdydH55fcZN1n28rucLYwTaJFnQ8myQosTPb
	 Fwc/h4i96r60gQYdP/qN95hsRMUBFRMm8UJN3A3/BcqbK+nt9KMBNqEDeIWhlo10ra
	 osWsu3p0S/nIg==
Date: Mon, 23 Feb 2026 10:11:22 -1000
Message-ID: <fce195603e59eec43bb115d96e0ce33d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>,
 David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Daniel Hodges <hodgesd@meta.com>,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v10] sched_ext: Fix ops.dequeue() semantics
In-Reply-To: <20260218083703.22785-1-arighi@nvidia.com>
References: <20260218083703.22785-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> Andrea Righi (4):
>   sched_ext: Properly mark SCX-internal migrations via sticky_cpu
>   sched_ext: Add rq parameter to dispatch_enqueue()
>   sched_ext: Fix ops.dequeue() semantics
>   selftests/sched_ext: Add test to validate ops.dequeue() semantics

Applied 1-4 to sched_ext/for-7.1 with the following minor changes:

- Dropped unused is_terminal_dsq() helper from 3/4.
- Fixed typo in 4/4 comment ("shared a user DSQ" -> "a shared user DSQ").

Thanks.
--
tejun
