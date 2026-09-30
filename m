Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957404F7CCF;
	Wed, 30 Sep 2026 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781279; cv=none; b=ttQeYSot/JDWhtG7XjNgdD3J0OBNnqjkfLrKVMGpBEQ5iwofSwzmKjtogOgBZ3dIZkGBO/FxFDgh7fq/RoaFGpg+fmrfupPqp7xWMCPPdmH/9gASiA+Phdg+eedLPAEFNoo3Oio7YWvx1SmfycNrdwI/NrSSXMfNBK2eNudC3aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781279; c=relaxed/simple;
	bh=clZs5+IMlzo2gwL34nPKM1Xvnd3bwkrjrd8B6OaniG0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References; b=EkHKpbkOokwXt1392WGi/Pdxco1l4JvDEGL3dNtfGdx7SDwetVVI5clR6x898qvMo/D6qpFLKVj1fl8ctjvZe6qGXJpflLpjsglcj1zb6zYhhGFEeAQUj7m7UzGqgFTmHna82s5ZLpqRy9sxANxw/VqHiL2QlhvVhlTvlwlZczw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=l6+wUBAr; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="l6+wUBAr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:From:To:Subject:Date; bh=clZs5+IMlzo2gwL
	34nPKM1Xvnd3bwkrjrd8B6OaniG0=; b=l6+wUBArEwqJvnyi8uQvKqP5JoEFkyw
	ab3DmuIOf+IKzqDhU4rxZdHCU089gKojuCX7PmVAyi2T0MT7l+GuE3IIDNs7tUWu
	RVq6Eiz/HZN0s6Cx1omtp6Eg0V6mPnY3tzc6+Zi+vtNw7LO+yzyFHVuY+Djq6UuG
	4rmrARCIMX78=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD33_JOJ71qs6grBw--.8932S2;
	Wed, 30 Sep 2026 23:14:23 +0800 (CST)
Message-ID: <cc4b38f88a9e64e7bae930f8aca026f4.sh_def@163.com>
From: Hui Su <sh_def@163.com>
To: sashiko-reviews@lists.linux.dev
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH] sched_ext: Hold DSQ refs for deferred reenqueues
Date: Thu, 01 Oct 2026 00:04:27 +0900
In-Reply-To: <20260930103603.DF9461F000FF@smtp.kernel.org>
References: <20260930101722.2468434-1-sh_def@163.com>
 <20260930103603.DF9461F000FF@smtp.kernel.org>
X-CM-TRANSID:_____wD33_JOJ71qs6grBw--.8932S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RXiSlDUUUU
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwhHnR2q9J1EAFQAA3H
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> Sashiko AI review found 2 potential issues to consider:
> - [High] sched_ext: invalid wait context calling kfree() under raw_spinlock_t
> - [High] sched_ext: UAF due to missing memory barrier in deferred reenqueue

Agreed.

Please disregard this version. It has been superseded by a later revision:
https://lore.kernel.org/lkml/20260930143443.2862150-1-sh_def@163.com/

The later posting should have been tagged v2; I accidentally omitted the
version tag. Sorry for the confusion.

