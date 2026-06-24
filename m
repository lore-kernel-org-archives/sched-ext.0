Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B67113AA2D;
	Wed, 24 Jun 2026 21:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782337565; cv=none; b=j6SsvYaXfed9OtFVF/kfz3BIQdfoITNtJO1AI8xzCNUnkzFfrzJqtxqP1ZHDHb7z3ct7Fh9gUmG31sG8SlOiLEJ5Wox+XgR7PirhwjX59i+jZCUXDJS5p1hrpFW21CEQhHrILnRXi7f6FV6+komsR51rQsGGFyOoYNrBesuydRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782337565; c=relaxed/simple;
	bh=qdYU/bSf6LLadGni+Kxk1fW265eoaZs78Yoz5MHEv2k=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=YKYt1qifPm5IRpo74Hu4/rj6HZbxRFxVXKNDwHOq163hN1+Q3aVvkSHkUe/qPkMwe2YNuALeMjfic6mNUxBMwAM97k/so0vbB63RCDiBQb/QPueEY2jLqypcdaljE+lC08EHAmz6ZRmNNAnarPqLOdlZcdcMBkHVMeL5djZD7mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDnm617+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDnm617+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A411F000E9;
	Wed, 24 Jun 2026 21:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782337564;
	bh=qdYU/bSf6LLadGni+Kxk1fW265eoaZs78Yoz5MHEv2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oDnm617+cmnB8CR3c3tUTpdUSf4NtoDLLYHtR8Wd2z8/dtS1MK6g9OBv4hF5lN8zK
	 hYEQScycrhbjTI+V8nKukBcGEngQb4s94hLVoGaxFJyS61388BNBcsNYmMnz1p9LX4
	 VmzNe6J1UNSkgg2ObhoCB8k10OsG2xISkDurWHxvDkYyIADByGI+fy+fNKFiKG3gY3
	 BtyXC1jnaLZ6WWzwqP4S+72NvOTAADIlT7z8mJ/MlPmiGOjJM7gL4+w+J6cxABFIGp
	 GiNyfePS0kwRvsUFxPeIWnSm9G+x1tmSh0WhMFNkjnNbdEFNwAZyQHzlRDogbVu190
	 UVjepxVmRz5LQ==
Date: Wed, 24 Jun 2026 11:46:03 -1000
Message-ID: <c34729df3de7a2d9bba857f8c0ab92d9@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH v2 sched_ext/for-7.1-fixes] sched_ext: Reset dsq_vtime and slice when a task leaves SCX
In-Reply-To: <20260608165557.3268661-1-arighi@nvidia.com>
References: <20260608165557.3268661-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.2-fixes.

Thanks.

--
tejun
