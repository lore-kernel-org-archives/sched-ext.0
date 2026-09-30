Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EDF4E4C30
	for <sched-ext@lists.linux.dev>; Wed, 30 Sep 2026 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782708; cv=none; b=emGgIwg3/WnT1mbPRhxpQIw3CmCuNuzFSRsuNq0NQrrt9TaUdjB7rwUT6h5Xesl0+rDrYrOlzQtvqyBACU5GwzR+Se/fo3/UuHkiYXoDwlVQ1U+JcTg1WUwU01pXhwI/uO9MmufP6c9tLfELXKo6t04R1lDpux2o+1qsB+mHvU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782708; c=relaxed/simple;
	bh=lFX3KZrfU92MnwavGd458xUvv9N7aTb4w8OPb37E7w4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References; b=Cn35vBdJfpFhTh/aQBVLECPZo4oqEFpNByAU9EbwckLI1RSxhSmshLT/J475ZVqDbUr+Wf88NCS0bctf3t0cd4pDFxuuklpsoJOWp7wVX+nj/0RN4vP4k8Dpd44u8Rc911yNG1s4lYAHqga2ACOVpeq8OvLINT5v8f8TPp8KClc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=c8oViUrZ; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="c8oViUrZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:From:To:Subject:Date; bh=lFX3KZrfU92Mnwa
	vGd458xUvv9N7aTb4w8OPb37E7w4=; b=c8oViUrZb745itfq7fMVxefKZ+XVeLl
	78tvnQ9DmI6OjNiChVYcOPztcQyErfVR+fT6XeUboaHZ+TgHiqrSpGgCvOi9ElMu
	fzdl6mNB/tm+KtoYC7UzT/mHG9qSV+iKP994uS2TlM5Jn1r/8o3TPmJGPsll8u1e
	SRe/DAkwrgfo=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3xwClLL1qzuoqBw--.14516S2;
	Wed, 30 Sep 2026 23:37:10 +0800 (CST)
Message-ID: <68e1d1e0cdfc633520a6593fdcdb3b72.sh_def@163.com>
From: Hui Su <sh_def@163.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
 void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 kprateek.nayak@amd.com,
 linux-kernel@vger.kernel.org,
 Hui Su <sh_def@163.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Hold DSQ refs for deferred reenqueues
Date: Thu, 01 Oct 2026 00:20:49 +0900
In-Reply-To: <20260930143443.2862150-1-sh_def@163.com>
References: <20260930143443.2862150-1-sh_def@163.com>
X-CM-TRANSID:_____wD3xwClLL1qzuoqBw--.14516S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRRuWlUUUUU
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwgY+nWq9LKZoPgAA3s
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Please disregard this posting. This was intended to be v2, but I
accidentally omitted the version tag.

I am preparing v3 to address the review feedback. In particular, it
will serialize exit_dsq() with deferred detach/reference acquisition
using deferred_reenq_lock, and keep final DSQ reclamation out of the
deferred path while the rq raw spinlock is held.

The revised design keeps a single DSQ refcount and the existing
rcu_head, without polling the refcount from repeated RCU callbacks.

I will post v3 after revalidation. Sorry for the confusion.

