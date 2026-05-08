Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ADB16F27F;
	Fri,  8 May 2026 00:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778199621; cv=none; b=ROQHxkUNCXCdumTQau7f+Qxcn8Jrk1qiGdo9iUFfywbQJNKQ615nLvIQPHm8GykbGmcU88FKItgLUvNYV1y9y4geOlNRbPdprYY23YL2xRoyruG0glryDTlH5ggvvM9ojXVo5inad/O0P3EzNYeG6t+/TBPlV5kQtmSFwrt0vuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778199621; c=relaxed/simple;
	bh=xkv4rowQSbrlz+DtnyHzM6Q4ND/p6P6zl8wnb2i6vJM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=a7jpZ45BKX2gXeHNIqcSgsbXol1tEX3u6nzLeHWLY41x0CjRLR6Z5xCdTOcgZJvp8CUxSC418/RVD7dzvLOKZDpRrmev9wJmgrSxXjx+lpxUj1udl3RHfMHaWPcplg5cDj/9jyTAvoWBxN+EOimIhjn1q89eQJWQ9sjoub/4+j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VF1qHsy/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VF1qHsy/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B80BC2BCB2;
	Fri,  8 May 2026 00:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778199621;
	bh=xkv4rowQSbrlz+DtnyHzM6Q4ND/p6P6zl8wnb2i6vJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VF1qHsy/QwgWTUvE6uDrZefg2pWyJDKkG0VscjSnJmPA7zVEwIDJiO0LzZpoQLh0B
	 TO9m7ktzAyA9leEaRG077LcHOGjL87Brh2rxsfGxp9VACJWtGOJTnCnnMF3MrM9oIQ
	 aM9WPQ3TZi6ljCaM1oJsZIn3iigR3StjW3XmmFx6Sn8XAEVDuJ5U6Iwj1vxQKWLKHh
	 dEfIZVgA45m7ks70IBTEx4/cicxWs/G+FD0LYum3mwHAObQ9UTrp2WC1J9H4pWmfaT
	 LYPdflS37xDt+F0/cBGbN3WiOWUNtkde83C0i0Si6eRUsRcBv/OASfDLmhvi101TdS
	 n3WvXACBG/CKQ==
Date: Thu, 07 May 2026 14:20:20 -1000
Message-ID: <b8ad65dcd9d150d1b7ae7a527094d8a8@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Fix !CONFIG_EXT_SUB_SCHED build warnings
In-Reply-To: <20260508001652.3477646-1-tj@kernel.org>
References: <20260508001652.3477646-1-tj@kernel.org>
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
