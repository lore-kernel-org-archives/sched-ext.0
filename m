Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFD533A032;
	Sat, 19 Sep 2026 00:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777654; cv=none; b=d85DsfbVFW8i5IPBN8tUefPagxtsqihFV/DOPkPBFBUvw3u3XmX1sLtxBXq7OREtD/9rYwOQY3FqjwtVxf44s8B7nxjg8Zu6BZhsjo7Ty6nklibs2hRfKT9JWiEMjOBE0egJsqQn3I3oRZJ8KVOIuNvxaJ0dvPxr3qv/tAL1qdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777654; c=relaxed/simple;
	bh=P7RRJyQ+m6eeOBG+041YY7eAdgcCDv5PFD6JcYAu35g=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YdXKpiZw3lAsZym/G/258NFS6k4zWiLazbM2xqpfFdL0H0U9By9CavjcoEV+4HvqJRk+3Q6SgHpCU03N8x56IQRR9CrRvsS8hu5FGe08I9QJbHrLhcbwa38v+YbMO2bHdKhEcpavuXVNi0s/MDLCGqfMcKkki6mFlE22ag6/dGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMT/+sXb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMT/+sXb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6831F000FF;
	Sat, 19 Sep 2026 00:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777650;
	bh=f5fsCItXOIze07jResx+Eay+ONXPYixz+iAVTaXPwcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gMT/+sXbWMoLL21rUT8LAb6TNLxzYllHwg1wiAcHzuyNu5SUaCYDm0pSq58RnZGS5
	 0O0txOflYxOgiQ8HMC3i/lrKPdtdEdfaUiDtWg6DDc+vVeMwvSLC1hbr9pAiIejq3w
	 RnXNqZy3sNkDP+WzTY1CZ7PfPlXDdV+FuB4vIRyGSj8f1ujt4r6kiph0Kv1c7grwp+
	 o+Xe30X7tH7ny3j5j5Ji4P8e1gps7vQo1qA8ZvdLsc6tqc5JcqpBfVSAInh77LyEBK
	 rgt6/MtkPov80haghsm/XRikgxLznmC0F9lxGBM+D5tPhIHZL+GAT0ouRzprCb32fo
	 VF5MhA6UGIe7Q==
Message-ID: <1c8cd97257ed5794d216432330b5c731@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <etsal@meta.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>,
 Cheng-Yang Chou <yphbchou0911@gmail.com>, Tao Cui <cui.tao@linux.dev>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v7 sched_ext/for-7.4] sched_ext: Add lazy preemption
 support
Date: Fri, 18 Sep 2026 14:00:14 -1000
In-Reply-To: <20260918171539.214204-1-arighi@nvidia.com>
References: <20260918171539.214204-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,

On Fri, Sep 18, 2026 at 07:13:26PM +0200, Andrea Righi wrote:
> Andrea Righi (2):
>       sched_ext: Add lazy preemption support
>       selftests/sched_ext: Add lazy preemption tests

Applied 1-2 to sched_ext/for-7.4. I refilled the code and comments.

Thanks.

--
tejun
