Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900B925486D;
	Mon, 17 Nov 2025 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763392542; cv=none; b=oel0JHcS3u3TQnC7g3jh+3a3Lxn8FwbSFmRMySJzXkHeslZn3nkTUejqSZenFzB8SGy4NCghRsgkv9/9KyI1xHV+YHn9lny5dxRBLik5b5AAVRxtMwgY6JugNjmmVMXqRmf/RcPMcD8G/EIFiqifJPU76xbPaICbrjp1G5xscVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763392542; c=relaxed/simple;
	bh=NBplsh0624Kjxvu8SMTCt/4O0tSu1lpyz5XBuZRcxiM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Deyhu1CKwLtG/Kegf0j3xzAYzGsYHm4jAemjYF+kBDsdQey/CkIMbuNaPX87vpOAumWmQYFS7jzaM3+zQcv/ZvygRGw8X+lJktZSAeU806m4ARYa48jDkJvaO6t75vzRNuj0TU1nGhdz9aKWoKA+NgmYgM5nQWxtPhGZrE9anqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTqofGm2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTqofGm2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0409DC116B1;
	Mon, 17 Nov 2025 15:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763392542;
	bh=NBplsh0624Kjxvu8SMTCt/4O0tSu1lpyz5XBuZRcxiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RTqofGm2JkklKT3G9LHe4JR72c56p5qjUPW7k/g7s/cWq6DHs2hViNn6+1LkdaH9+
	 2XDv6h7LN8pfhtFHDNCD34IVZC2hrb9bVGR6P3bA26kNmYxfUnR0E6q8i0jf1MbZLK
	 KP66zFrfTXhxijHMyi+E2UJE9+fukioe0MPuuqXV+eMS8sHSR+k+ECuiPMfYskDrRR
	 wTmAbpCGiEnX6tKRhM2/y1IZAE3bSjMywd4eNSgNld0YoHWu3Zq73VDbPi+I+1sP8U
	 luW046/asuWgzayxewnUpiiWBfbYjOWUGocCaqWaW2ygyFLw0pB8nXnWKyxoT4w6LD
	 FIB60wxYcL2Sw==
Date: Mon, 17 Nov 2025 05:15:41 -1000
Message-ID: <0c8b3422ac8b03f83828a91b5510e369@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 qiang.zhang1211@gmail.com
Subject: Re: [PATCH] sched_ext: Use IRQ_WORK_INIT_HARD() to initialize
 rq->scx.kick_cpus_irq_work
In-Reply-To: <20251117125311.107687-1-qiang.zhang@linux.dev>
References: <20251117125311.107687-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-6.18-fixes.

Thanks.
--
tejun
