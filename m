Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EEE3A7597;
	Fri, 10 Apr 2026 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775811255; cv=none; b=OftIXGR5J7pYeYM0wnIn7YAdFvxbf/GMjijOCF5mRuhbxVNGUK4fuw3FRGSlpUo0rYmWYlo5jjAVdadgK/5qqGAltwQ0MWyT4a5AAGYN1btIA9kaWDbc/HGUIDfR/GiFOTEiWwaAtpRBta1GWK7F0MeMF/rgglAJn3gzfGMB1xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775811255; c=relaxed/simple;
	bh=I5LvUHuZq/0J0I+pjHNrLVfC0wpQAby6zQJ582lhRR4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=ssu8qV+iQmzOB715W6UPlQEcMG9iVl6rEelsHZVrlHhI9d6JvapHCyN38l5/bSCWHZLMmxQmu7QmSCzdpiPdrILruVzR6pUea3+XB7b2FTqzSNTf4jvv4uK6MXfeDCBML/gV5ZR0uNOKBEMOCOnxc7QghsPNB/X33YIgcrNT/UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixBuw1f0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixBuw1f0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B99C19424;
	Fri, 10 Apr 2026 08:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775811254;
	bh=I5LvUHuZq/0J0I+pjHNrLVfC0wpQAby6zQJ582lhRR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ixBuw1f0bSPz9y5T/nAKiz0Nu0ZYFcDokmUbnVniwUbePKALCpzi31E9vKfI4KDro
	 CU+vA99SuikuHStrTCakcrF+nTfJqWDk0SdRsWkS17DMQySwKobhYZLTo4ytrYjzGZ
	 QTuGAA4E1IhJNls62apFighQf/iOqbE/E7XbHO264Mu+xE7s6TulLmMT3CKG6LytCv
	 K3S3sk023/SCMgXOVpQC68CGdVltXHFVRy+n+jy93HpbfY6jzv2w8gD9Xja0sLk/a0
	 E0NU8q8nGh4gE5t0lzGtpIvbie/M+MXVymq1Tov9FiZlRkaTDS1G5xzTLDXtSfiCJQ
	 iV+pZJd/iZhew==
Date: Thu, 09 Apr 2026 22:54:14 -1000
Message-ID: <e6d64e846bffe480d8a381ca00fac743@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 David Vernet <void@manifault.com>,
 Christian Loehle <christian.loehle@arm.com>,
 linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH v2 sched_ext/for-7.1] sched_ext: Documentation: improve
 accuracy of task lifecycle pseudo-code
In-Reply-To: <20260409165744.1526489-1-jpiecuch@google.com>
References: <20260409165744.1526489-1-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.1 with the following minor typo fixes:

- "a rough overview the entire" -> "a rough overview of the entire"
- "in which it will exit" -> "in which case it will exit"

Thanks.

--
tejun
