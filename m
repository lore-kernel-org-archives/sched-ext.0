Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C159F389E13;
	Wed, 29 Apr 2026 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777482413; cv=none; b=n96yMCDwh+witA0Z0DlCZqvXwzwGJg17graYR1ezr77cgDZ3uWEQPzGoRT5R+AmCPp4bcXNCrD1Rv1CULfADcbjyy50CX6pbkoIUwjwCOAoHopJZ6jMfxdWe+hFx2QcMAKZA57UGRU9diVgokpof9TLE+4NqPFodq6pcHdAzAjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777482413; c=relaxed/simple;
	bh=nc+y0NJvPYiLTAW0Pawk7lu48/qkPRqXIpSq/JJvMp4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=DGe7Mc1LKUZuVDdRIM/kH4MuMEviJo1b9w4kv9RXLLV14rtuAeOsl/rFUuqb435PTHQFNtB4BqPiPkAu8CMhEGJox7V4KtPJSxWNAUU4TAmLwJxmizDrQk83IRpskbgSKG67V+4oXRile4Q2f4WlVgOJ2vLSOOKZBb8OgRK/gJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYEyNLZg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYEyNLZg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DC3C19425;
	Wed, 29 Apr 2026 17:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777482413;
	bh=nc+y0NJvPYiLTAW0Pawk7lu48/qkPRqXIpSq/JJvMp4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AYEyNLZg0ygX/oqzLvOScoywFuBecl+eBpf98HjEsJ9dIWlh0sc3jfAnNMZqJ1L94
	 LUvsnUFbOVDeIer/zv4534XOKxZWQNPXvMamSog8+KWiBszSPymv4eRsiHJ5dBchBV
	 msmbPXJCjVB5sACD/sMn5+NRVI9TWQtkqHP0mq7/fVdH7nohEwm6ISUm5wce9mhwhS
	 P9m8jsjB4rF9bRU7yBEjtFyslymfO91oEDn9UXag47W0XVWI0qAjksL/07rBczwav+
	 SmVxNodH7Y0MWrhWm4J+WqBD/LCZCuW6G7m8aYJUYQgerJMPfiWup9+V0rM0TXeYbT
	 WSclVANqeMjqQ==
Date: Wed, 29 Apr 2026 07:06:52 -1000
Message-ID: <f94a79fcbc4fa07c470c2b6f0fd2e6c9@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>,
 sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v3 sched_ext/for-7.2] sched_ext: Topological CPU IDs and cid-form struct_ops
In-Reply-To: <afIHuXXJWHEJnzaO@gpd4>
References: <20260428203545.181052-1-tj@kernel.org>
 <afIHuXXJWHEJnzaO@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Yeah. Expanding the in-kernel idle selector to be sub-sched-aware is
hard - it has to respect each sub-sched's cid window, partition
constraints, etc. Cmask in arena makes the same logic a lot easier
to express on the BPF side, so I think the right path is building
that infra in BPF rather than extending ext_idle.c.

Thanks.

--
tejun
