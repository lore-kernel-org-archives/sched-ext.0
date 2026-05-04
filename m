Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D842431716F;
	Mon,  4 May 2026 21:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777929814; cv=none; b=s9u0C76TCHeAyM0FQGqIy1MDB/53M1fq5Dm7Ngwe3USAa3nIIGwrdIWH08aTP232zLaIFF75+ezN6mN3Qg5ty78QsdtLMBT3xnZkpOK0ORVZTKp1kKVczBdKoo/P/cejJTewnKDSsK58Y9NNTOaU0C5bwt1KxRSSzlHI8cnx7vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777929814; c=relaxed/simple;
	bh=qwdHNsm339DgGlPwlYlDBmESvB43wCN5K9Fa8rDpWmI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=GhOD6IZXi24TOb6rwbxWcwvzsIpxaz4ToMDLO12IyhZ7rFjBFd+JiIImjZwmj7YNIKD5EUol7H8uZGDNBRXxftwEP3R20nyJDQycBKGp4eHYczlJNJFiKFJnLLSkL5UPnRRgtebVVVOfQlkR+t6Y2/28FYvbzl5XzhHKaULm+KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IO7vmlo7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IO7vmlo7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1917EC2BCB8;
	Mon,  4 May 2026 21:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777929814;
	bh=qwdHNsm339DgGlPwlYlDBmESvB43wCN5K9Fa8rDpWmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IO7vmlo7X1YIGHIRiNVgsErE7bOImofPu3pPKqi+IWkuWnJsKZ6qMAL80+QaJ4S6f
	 ZCvyhjBQsbnGe5SETuNijo0+z7mSMkhFxmsr4/j9hZbn4WPWfJOP4TrYESRaczK5lg
	 Xvug/n4+pqxJ0Ui5Fe2wB7cC13otbdKCNSYGApuW66OYw5MDkFfD7x1ps6yz9hX61J
	 3ZSrdCBBA2yN0VQVml+Fm6KF9/5BBsZN9MQlSNtTwci++9I7Rn7HPSezfFiVR49ipj
	 +t+k+Ps5DjjeT7NR1gxO2+JhZr29LCQOZeb4Mr+GsPDMDvlIjhB0kFyaW6zwu8Vido
	 P8iDnJyv+vqdQ==
Date: Mon, 04 May 2026 11:23:33 -1000
Message-ID: <f54b9a18bb2e5b429ca9bffea6bc119a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
 kernel test robot <lkp@intel.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.2] sched_ext: Add __printf format attributes to scx_vexit() and bstr formatters
In-Reply-To: <d49b20910d6d09389af138f45acbfaf0@kernel.org>
References: <d49b20910d6d09389af138f45acbfaf0@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.2.

Thanks.

--
tejun
