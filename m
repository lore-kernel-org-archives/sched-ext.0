Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34CB10F0;
	Thu, 16 Jul 2026 00:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784160025; cv=none; b=GuMHx14dcuvrwUCvg8w7sOKLsc55ZnPPLsbHx9gLA5PRWDty9kChFGv5qoHYbXtvA/blyUZRNYJvrGCbYeeuEl07eBBRx2VPJV4Ikx+lWyCFFOdPLDmkx1RCBgFzhptpKHBG9xM4Wst1A6+Zuw6ssFGVBYI3Ck0oS6eYABTql74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784160025; c=relaxed/simple;
	bh=qxaGXMQc3jt6VVA5w4TJnJoORphubhT5qy72SVgvOoM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=hLcHWwU5R+/HhA5+Pl6kXpb1OJhfsiyIhSvzsf9VYg21yYy0wV6vdiZ+G6blgWsuYq+Xic5L/vp24GP1GtCIJs4o0T0viv+8Cvm5XM2Y/WVhWMA/YENQSO9eQii/l/qxCeOuZfBW4wct6x58PTO8q1Qx/9Rv5OBc16BlWAIfKvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dG54NpMW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dG54NpMW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B8A1F00A3A;
	Thu, 16 Jul 2026 00:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784160024;
	bh=qxaGXMQc3jt6VVA5w4TJnJoORphubhT5qy72SVgvOoM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dG54NpMWi49gbTNMTEgF4+dXeV1NsCf+h1QtMFMlXM97pcXazzwVQJfACtzuOKZai
	 iGcDheHXZmBSktjOBO7p+4//44X4tIhzGYRpElo2PffV6GikxyGBPR4AA9xaatwe2a
	 kh+4KBIj23i2Sn0BPl7dctS/5lKHAqNKlCP2BgpzGMOm6vuKpV3OlTAc9WtsoiLjE8
	 HMggc1FVCNMgn/AeBT9TI1IPZG59ZtDDxY5xE17cdfiScICrMSVBRbBvODszSc2B6G
	 FyHdT2Eds0i0gZiEEqnzXEmv+mE+DjPi38+nzzP2GXTfZvVnidwcifzNlSL7sHOiRH
	 zfdwtc+oFVcXw==
Date: Wed, 15 Jul 2026 14:00:23 -1000
Message-ID: <cc23322868a54b08403fe9f8db5eae0d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCHSET v2 sched_ext/for-7.3] sched_ext: Sub-scheduler
 follow-ups
In-Reply-To: <20260715235133.810434-1-tj@kernel.org>
References: <20260715235133.810434-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied 1-4 to sched_ext/for-7.3.

Thanks.

--
tejun
