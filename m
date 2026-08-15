Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400EE37F31B;
	Sat, 15 Aug 2026 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786788628; cv=none; b=PZVgXQZ8EBsiSxZauQGlCBqLKWI/7YXbXlUqoJdS/aaPnAMS/qEIb8SJWR9pXO2vkvgcPPMnn1WbxKq5s2eq+qpnmeUkzdSTOm/RrVwFgy12AUoWApQS/8ojnY2b5lcGqp0EckAWuljrn5SUP1ilotD9KzHJKppcegT5Y3IE8JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786788628; c=relaxed/simple;
	bh=PtD24CuAPAd5D795AdNEZvWEx7rpIQjupDI9rzIMuKc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=XjpGNTs5uTt7/8ypp6X9GoopyJOb+fMFkuMdqWyzOv3QaBVNv3XnebK1itD4aEMlFVNLTIsV1tN3eKH+mpRe/YzxTuWh9L84Xc770stgWnnVnLQPPW4QxyMsGQsItT/U/Bs1rM4OeCA4yyer1W7IPFyOvhpwpRQxj7AN/NjtKhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyJZLhLR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyJZLhLR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937251F000E9;
	Sat, 15 Aug 2026 10:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786788626;
	bh=TJkpyB1xCkC3V4XmKBsXPG5MnvqX7LcYWw9EU3+zSuk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UyJZLhLRik7SUD2Vcs+GLY2dPJjMSU2GfFNy0fpHqwOcLUk0UJ1F8G3OChPaYNBpx
	 cgercjYwy87XYG6BeF+95tvyiFLS56Y8KfB9TN2mwGQoMi7ka0D7T8ct2Y9xiqPCAD
	 iLE76XXwoav7hoq1RXbKGOYLg4/iEYmwZmhaNh5davOqaNAy2+HlMG4Qj0XcbcwXtw
	 scmEwtMkLT9zlB/v2DO7qnpVBCx6l6nC6Ccitp2Ra82ZK6RZix1E/RyC60jQQ8Ua1H
	 64oRG1PwlkfGQWpQKyUiEx+jpVV6D2/vJE2NOtfw4BsVzibsFqioRpowjiGKnucbFp
	 t4nFHlZwO0u0g==
Date: Sat, 15 Aug 2026 00:10:25 -1000
Message-ID: <b63b856f7725bc14f2fe4dcece0022fc@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCHSET sched_ext/for-7.3] sched_ext: Dispatch path follow-ups
In-Reply-To: <20260815010532.3663253-1-tj@kernel.org>
References: <20260815010532.3663253-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied 1-3 to sched_ext/for-7.3.

Thanks.

-- 
tejun
