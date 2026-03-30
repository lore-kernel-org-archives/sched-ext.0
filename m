Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2523AD50F
	for <sched-ext@lists.linux.dev>; Mon, 30 Mar 2026 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860697; cv=none; b=uZDuvrtkJ3awX2G0Rxw6aIjGaKyESRUPkDdJ1+2soCuBW71/5HVqjTjbldox2+HlsOcPDmyNdPyFR94Xmy41nTaplQjyimiR4FsF5uZ4vyKeXLG61TVSD3UFheDcBDFfGViVNYkibhgcgFWAhi8FBEl0Zl9npWZ1UTnqZ3m2+2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860697; c=relaxed/simple;
	bh=DwD1DsSkIZC/Y1yrfZ4Aog/2TnNiAlz9yKJBYrkREas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PMFPM5Vi7oIMpCwm1Fve6HlqRd10KETfNOVBqRZq4Vrv2g6mr+mFX4U8GEzBF7zboWXGa3tUkon1QZLIYvKgK+BZQuCbZJJg+Qv2uP8lAUD8u7Qf1hgdLg2S3JLSKRYv/W1n958aPHEi1bZadPwDtgy+TbRg06Y1RPoQ1teHO7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TX6BQxm8; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TX6BQxm8"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16FD31C00;
	Mon, 30 Mar 2026 01:51:28 -0700 (PDT)
Received: from [10.1.32.28] (e127648.arm.com [10.1.32.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3CA43F915;
	Mon, 30 Mar 2026 01:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774860693; bh=DwD1DsSkIZC/Y1yrfZ4Aog/2TnNiAlz9yKJBYrkREas=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TX6BQxm8cCikgdTWGKhOxxEmebbQuNGet6wEVDUVqRqj7/SMxQkZyMPm0h0c2CYYX
	 klmKkLN8vrjQSR5IM5xU4TEyJMOGUq646ZKShdqTzJZfCLPYzu0saU2wXjTeZPcoIH
	 7ziho55PBCNJPZJ6MLnAnfzELtX6olXhMD/y6di0=
Message-ID: <5e3191ef-32cb-44a3-90a1-66ad8327a030@arm.com>
Date: Mon, 30 Mar 2026 09:51:31 +0100
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add cyclic SCX_KICK_WAIT stress
 test
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260329001856.835643-1-tj@kernel.org>
 <20260329001856.835643-3-tj@kernel.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260329001856.835643-3-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/29/26 00:18, Tejun Heo wrote:
> Add a test that creates a 3-CPU kick_wait cycle (A->B->C->A). A BPF
> scheduler kicks the next CPU in the ring with SCX_KICK_WAIT on every
> enqueue while userspace workers generate continuous scheduling churn via
> sched_yield(). Without the preceding fix, this hangs the machine within seconds.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
