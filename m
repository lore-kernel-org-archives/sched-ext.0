Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C69D24A047;
	Fri, 17 Apr 2026 18:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776451114; cv=none; b=rZirA32Rp/89rIMbxA/V3kqZGKRt4VjcLSpc3xIN2Gs/Kv2PzAMn+YF5vM/5TNhHdCL/mLApvPeap/q51OWi+Khh1jazpTX5x4HTrQrPXDOviXNmTPvQ2x5M1xygDjL0eOLFwMbA8Cw5iuEfJDV4QUR02tytyXJm3yT7v6TvniA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776451114; c=relaxed/simple;
	bh=QMYCbiu4UslwGII4hGwxgtxjwyvT++A+3NQrbFHRAHc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=D37T25pU859GKTRiS0VdRmfml44v2w0sloTOmcc9NfK87yoVLuYupGmdiyRDAkypZXvhmcLEA422J/+f2b6e70In8d5eRno0xbAvIvhHgoffv6QvSP08ZiipQNUa9pWevgTB+WUBzgwQyrIAUVRy2RbdFJKm18tqCVuVc7BZCK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQwIpAMK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQwIpAMK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DE6C19425;
	Fri, 17 Apr 2026 18:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776451113;
	bh=QMYCbiu4UslwGII4hGwxgtxjwyvT++A+3NQrbFHRAHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sQwIpAMKjexAbUtvIpEbPfY35BjFXbdT0kA+a5T0xCNK2bOY3SN5tcmc4DAKWvJh4
	 2cktZGdDV5TSnVMjPVV2d/08/WlP2L4Uoq81z5d/bgzFU+7e3Wq9ctbvfC8Kbm76x1
	 tx1VcYM2eJeeYPQbx/bWvpA1vBEeUEV995k6kCHTUxSlS0JNF5QewQyPTg0+gwTap/
	 tw+rhWPks+vVfjEahHi4bMIORhnhWE+oo+ojtJuPJdD7Y+blleHYwkztyY9mp8hAjS
	 q2bVMaGmaOJMdDEqNhT1Xd6j8z1N+WgEydND51Wpd24u5nGBY3chp9BT1P0S1xUpdi
	 Vq0oVqxw76WOg==
Date: Fri, 17 Apr 2026 08:38:32 -1000
Message-ID: <f142e9af1dcb51fb14f559f65d54d26b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org, Zhao Mengmeng <zhaomengmeng@kylinos.cn>,
 Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: Re: [PATCH v3 0/2] sched_ext: Cgroup sub-scheduler minor fixes
In-Reply-To: <20260417-sched_ext-0417-v3-0-e11b3aed57d3@kylinos.cn>
References: <20260417-sched_ext-0417-v3-0-e11b3aed57d3@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

> Zhao Mengmeng (2):
>   tools/sched_ext: Add missing -c option in scx_qmap help
>   sched_ext: Print sub-scheduler disabled log and reason

Applied to sched_ext/for-7.2.

Thanks.

--
tejun
