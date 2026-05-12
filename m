Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF9A3859FA;
	Tue, 12 May 2026 21:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778621621; cv=none; b=gCd0QmKqI2yEDdjvSkLZer5t7ToVv/HzP84ayJsrwkxhcm1AbYEsQaJ5iV+J13HTokT0GNDuHikfrBVPh0xH9f7XP/DQUvobYGVCOjO9oOuo+gPTH525gRam7C3PFWsDRX2OSSUUOENsEchzjhio1aWRsoMTTahGyy9r/Z+sZkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778621621; c=relaxed/simple;
	bh=xkv4rowQSbrlz+DtnyHzM6Q4ND/p6P6zl8wnb2i6vJM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=It+/FLxOxT+TjaW6wQtMbKLczC094wzlZJH5jbJi1etjY5Zpth2f1HP0JtilIgy0foyEwdecGHhwrJn3CqGsG+XGsGAKrLLToZSD9cNuWRDDaZ6J8QtwQF4JGGmuNv+ZfJ7cEGF0H4/TrKC4gpMS4E1z2TWGaUU7ayxTiwOHSNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdeZyXb9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdeZyXb9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A550C2BCF5;
	Tue, 12 May 2026 21:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778621621;
	bh=xkv4rowQSbrlz+DtnyHzM6Q4ND/p6P6zl8wnb2i6vJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VdeZyXb9QJaoFK9R7eGG8yFdc4QW5TgcWfDnhPGxUPcJ/n/I5S6JdCTQfHPbItUBL
	 uJa7VzIusgWvoNNsc9mvlarlw7DzFwczcUP0hMNfoKN71rO8wuRLFr1x4ISFT+dAL0
	 V2bkVJwS4BWjEhewA1MPB17fYTA9xyIJTqFNa+aEHvljrGggvfiz5a0HmNKYSACzoO
	 9L2OscwVZBWqNTaMYMhVjo05MsA7oeuGFXDqDnjfZpB/XI4Hka5FoImoGY++++N0rJ
	 oJd/qiR5JXADUFuXx/zklHrqQNnBF46u2+mDDFY1ia7xYjUugkpRFIfcG9DJu2oE9l
	 EgKZSMIc2N9zg==
Date: Tue, 12 May 2026 11:33:40 -1000
Message-ID: <8e962b24958a3a5f4312ee236539757b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Defer sub_kset base put to scx_sched_free_rcu_work
In-Reply-To: <2f2b7481ef217ad89c5d90fd56fc0c01@kernel.org>
References: <2f2b7481ef217ad89c5d90fd56fc0c01@kernel.org>
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
