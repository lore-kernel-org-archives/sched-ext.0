Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E654360EED;
	Wed, 27 May 2026 19:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779909386; cv=none; b=KY1laLJDvTIgoWhWDJeh9VZpGr0egTxNGSZ8jx8Og5kdna2a/d/ZfP+QyqwN5QP/o9QN3/hgM3OPYWoYEhrGE/H6N/jStF0QIotcB0uvddn/OLEiKGfTduXAU5VKdf4WThP8Ht0j3iNvcCtmd8dX8mNXw9koHX/bzyu/C0m7p3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779909386; c=relaxed/simple;
	bh=xkv4rowQSbrlz+DtnyHzM6Q4ND/p6P6zl8wnb2i6vJM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=i3KxgM2YNQxWgqZyvmIXVi36fekQ1/DkCj/3B9p4selnecMAwbODJqH02IJz9OUwX+aBqVAC7tEXVh8ShwidafnsAf/roAqWRCvnPTrvnqTmoWloabgqA3Fd1IhYrk/ZQz6NjiUlw5BitYiU6s9I2CYHMcweeDgSSX8lSJfm2Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OclHAohs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OclHAohs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648B71F000E9;
	Wed, 27 May 2026 19:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779909384;
	bh=xkv4rowQSbrlz+DtnyHzM6Q4ND/p6P6zl8wnb2i6vJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OclHAohsViycglISjgX8L2w929B5+czXAIcgm8pzssLqgJ7vi5ioMR56NyIBJYclj
	 KKraxtMqZ3Gt7dDXuPAWnikoxL+h2FUmqFoU6xxU9gLnrxAhqKOgcyw7wXJJBEzlfW
	 5++uCXkeK0emwxiG79v4jYuYCt4TwnENxMFFzVldWBX6azzlBFxYmcszMS5pTlpAgM
	 riZEoMp+Oq3QBKyroS6bzJPogBDeYVZABIr74lQLBSyAhJXpO707geJPANuLoTT3+S
	 BZb9BNIDXLWwOVzFO4OwBNtAytdUM3BRzZYVPgJyz/2yTGp3UfUJE5mFvMGjPxwjnD
	 gWAr51tt9LsEg==
Date: Wed, 27 May 2026 09:16:23 -1000
Message-ID: <17796e83fa4437525bbff8211f0af079@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Zicheng Qu <quzicheng315@gmail.com>, Andrea Righi <arighi@nvidia.com>
Cc: changwoo@igalia.com, enjuk@amazon.com, emil@etsalapatis.com, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, tanghui20@huawei.com, zhangqiao22@huawei.com, quzicheng@huawei.com, void@manifault.com
Subject: Re: [PATCH v2] tools/sched_ext: Fix scx_show_state per-scheduler state reads
In-Reply-To: <20260527093850.3493647-1-quzicheng315@gmail.com>
References: <ahXcAzxZbw6g_dLO@gpd4> <20260527093850.3493647-1-quzicheng315@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.1-fixes.

Thanks.

--
tejun
