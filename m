Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15B0372ECA;
	Sun, 22 Mar 2026 20:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774210351; cv=none; b=m+INfvjOct82TMK/NvK13reKvz+E3r2QRy5Bckbb6aTb6MkvfMbeASpz6st9KxP2MXIjyLSv6mRqWIMJxNpdd38553ipdy21ZN/bqolYv7f77dPgSID1etSx+/GI0B4TJlzS5jFH1oKdDmj0E8o1XztocTs/dBOg60SHX/Q+gVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774210351; c=relaxed/simple;
	bh=KMpDixRY98Ywf9AzSIdELr5zZeN8uW4bl5XbDgAWP3o=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=U5eu4I/wCF6mhEh61BAoeo6s2fkSb1mlv/9eehu34wRczwzlMUcFz8ZuOZ6zn/9mk2wpH389/8qviNyvMD4Um//MyejuXIQE7GNHO2aLGB70CI+02O8VMssqaQ764TvslZlprVR92SqlDzK5lp0TG69NmiSjKKNCUamoNfOYWDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lj8UYYaG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lj8UYYaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AF8C19424;
	Sun, 22 Mar 2026 20:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774210350;
	bh=KMpDixRY98Ywf9AzSIdELr5zZeN8uW4bl5XbDgAWP3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lj8UYYaGhi8SrZp1G/Neykam126sulm9Wm3g53PT8WzfzL+U8CVGL/QtOvGDrhkaX
	 HNazDZY8TemKw0iOdo/oKeO9wDh2pBciAULzL+WEiC1uSz/u5lGpW2gO2+B1xmVNh7
	 3Q80nMSzl8W6KsBIy3VPFQc1i8XBwNH9CwsTi9E0CrzL7Rbsc7UEd0S/hk2u9aPPxo
	 7gCc+XXU0+b2YvvA3UrON26EgBel9PShw4aIeRhpd6Ih1GAedZS+X/84QH/IrZfsTQ
	 NwpArBGQzw9kIzTdsV4j7pvQfoUxFLYTk2GNwHH4bwzmxkCuX4gW4HpiHKiAGNlf3W
	 5uCA0X5uLwxwg==
Date: Sun, 22 Mar 2026 10:12:29 -1000
Message-ID: <b75214fecccfd6256768f87daa7edb29@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>,
 sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1] tools/sched_ext: Add __COMPAT
 wrapper for scx_bpf_sub_dispatch()
In-Reply-To: <20260322144433.1649092-1-yphbchou0911@gmail.com>
References: <20260322144433.1649092-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Let's not use the __COMPAT prefix. I'd like to move toward making compat
wrappers transparent so that schedulers don't need code changes for
compatibility as much as reasonably possible.

Instead, declare the kfunc with a ___compat suffix and provide a static
inline wrapper with the original name, like scx_bpf_dsq_insert() does:

  bool scx_bpf_sub_dispatch___compat(u64 cgroup_id) __ksym __weak;

  static inline bool scx_bpf_sub_dispatch(u64 cgroup_id)
  {
  	if (bpf_ksym_exists(scx_bpf_sub_dispatch___compat))
  		return scx_bpf_sub_dispatch___compat(cgroup_id);
  	return false;
  }

See tools/sched_ext/include/scx/compat.bpf.h around line 326-342 for the
full pattern.

This way schedulers just call scx_bpf_sub_dispatch() directly and the
compat layer handles everything. The no-op fallback (returning false) is
fine here since without sub-sched support the dispatch path can't do
anything useful anyway.

Thanks.

--
tejun
