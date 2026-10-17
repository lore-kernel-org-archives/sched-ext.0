Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA96224D6;
	Sat, 17 Oct 2026 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792251292; cv=none; b=OdJ76Cz3Crbupj0ThDNgleTjO2NWRfV4EguH4qIT2WrqA1FUsF8DNduf9WDdexZC+BpVvhkpQ6tWEeNYBevY+7VJ9wwzBoXHaIgC4DQOKHHXvjquStxHZ7xOIo81oAR1cn3j6ScVVQZQVC6/+knPesGdIy+ilaUpbfeg59Nidbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792251292; c=relaxed/simple;
	bh=zeI8DZTfIJHDQSQ+vw5wwTi/Ps4ofZyRS1SPOt/Rvuo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=hM24soor4hPJKgV9P9vzwpDj6Pcj/KXWaigD7QJJRjBxv611dcMIn4hpG0RGhafPZnAsAo09wxIfYBA8Ps3Y1VOajdmyrGu6oAjSIC+H43Bq2k6+Ec3XItuS4ePH9Zs4iPNQBgFc7NuwfFZAlv7j+LxfzSlfLXo+CsTwb90dQPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAzvO6Kh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAzvO6Kh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230BA1F000C4;
	Sat, 17 Oct 2026 15:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792251291;
	bh=izOEVULDL8kG0N2rTV/wStLaI6Xe5O89Gtvoue+cvPk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HAzvO6KhCCwY5MMdVp3VRO9dkFY1UCFAW6+n1Im3+z7llqt1idJCq2PXOch0tmgxV
	 oQOyfDG12msMRO0Rl3WwkTWnHl/LvTzLcf0oAEZ34beKXxpEtOhYV9X4HVUz0/gC9L
	 C0D+Ib8suMsGTuMBu3/+PQaIa6zDm3DvemVnG5OwjM18iUEOFAQdOJhBPxpB8GH4jC
	 VadrXHOSUsj9ydX7HHzWuzCf4i07cDIaXkJcwNPjEd++ok5DB7sHK8n43FEsa5BZcJ
	 LC9CkzS7Df4dHDMCBwDQPIz3v5z/cgzTltIhd66AVkd5kznSuDNzFv1niTerrS/wcM
	 LZzEtYLjO4WMg==
Date: Sat, 17 Oct 2026 05:34:50 -1000
Message-ID: <74cb2c89df23fe72711e7018655c589b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.3-fixes] sched_ext: Fix bypass leaving the running task protected and bypassed tasks stranded
In-Reply-To: <20261017053717.3162619-1-tj@kernel.org>
References: <20261017053717.3162619-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

>  0001 sched_ext: Fix the running task keeping its protection into bypass
>  0002 sched_ext: Fix a bypassed task stalling on a cpu its scheduler has no caps on

Applied 1-2 to sched_ext/for-7.3-fixes.

Thanks.

-- 
tejun
